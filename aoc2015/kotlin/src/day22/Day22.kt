package day22

import day22.EffectType.*
import java.util.*
import kotlin.math.max
import kotlin.math.min

data class Character(
    val hitpoints: Int,
    val mana: Int = 0,
    val damage: Int = 0,
    val shield: Int = 0,
    val effects: Map<EffectType, Effect> = emptyMap()
) {
    val dead get() = hitpoints <= 0

    fun addEffect(type: EffectType, effect: Effect) =
        if (effect.duration == 0)
            this
        else
            copy(effects = effects.plus(type to effect))

    fun turn() = copy(shield = 0).applyEffects()

    private fun applyEffects() =
        effects.values
            .fold(this) { character, effect -> effect.affect(character) }
            .copy(effects = effects.entries
                .filter { (_, effect) -> effect.duration > 1 }
                .map { (type, effect) -> type to effect.copy(duration = effect.duration - 1) }
                .toMap()
            )
}

data class Spell(
    val manaCost: Int = 0,
    private val condition: (caster: Character, target: Character) -> Boolean = { _, _ -> true },
    val effect: (caster: Character, target: Character) -> Pair<Character, Character>
) {
    fun valid(caster: Character, target: Character) =
        caster.mana >= manaCost && condition(caster, target)
}

enum class EffectType { SHIELD, POISON, RECHARGE }

data class Effect(
    val duration: Int,
    val affect: (affectee: Character) -> Character
)

val magicMissile = Spell(
    manaCost = 53,
    effect = { caster, target ->
        Pair(
            caster,
            target.copy(hitpoints = target.hitpoints - 4)
        )
    }
)

val drain = Spell(
    manaCost = 73,
    effect = { caster, target ->
        Pair(
            caster.copy(hitpoints = caster.hitpoints + 2),
            target.copy(hitpoints = target.hitpoints - 2)
        )
    }
)

val shield = Spell(
    manaCost = 113,
    condition = { target, _ -> !target.effects.containsKey(SHIELD) },
    effect = { caster, target ->
        Pair(
            caster.addEffect(
                SHIELD,
                Effect(duration = 6) { affectee -> affectee.copy(shield = affectee.shield + 7) }
            ),
            target
        )
    }
)

val poison = Spell(
    manaCost = 173,
    condition = { _, target -> !target.effects.containsKey(POISON) },
    effect = { caster, target ->
        Pair(
            caster,
            target.addEffect(
                POISON,
                Effect(duration = 6) { affectee -> affectee.copy(hitpoints = affectee.hitpoints - 3) }
            )
        )
    }
)

val recharge = Spell(
    manaCost = 229,
    condition = { caster, _ -> !caster.effects.containsKey(RECHARGE) },
    effect = { caster, target ->
        Pair(
            caster.addEffect(
                RECHARGE,
                Effect(duration = 5) { affectee -> affectee.copy(mana = affectee.mana + 101) }
            ),
            target
        )
    }
)

data class GameState(
    val player: Character,
    val boss: Character,
    val manaSpent: Int = 0
) {
    fun turn() = gameOverOr { GameState(player.turn(), boss.turn(), manaSpent) }

    fun playerMove(spell: Spell) = gameOverOr {
        val (player, boss) = spell.effect(player, boss)

        GameState(
            player.copy(mana = player.mana - spell.manaCost),
            boss,
            manaSpent + spell.manaCost
        )
    }

    fun bossMove() = gameOverOr {
        copy(
            player = player.copy(
                hitpoints = player.hitpoints - max(1, boss.damage - player.shield)
            )
        )
    }

    private fun gameOverOr(tick: () -> GameState): GameState {
        if (player.dead || boss.dead)
            return this

        return tick()
    }
}

val spells = sequenceOf(
    magicMissile,
    drain,
    shield,
    poison,
    recharge
)

fun main() {
    val initialState = GameState(
        player = Character(hitpoints = 50, mana = 500),
        boss = Character(hitpoints = 71, damage = 10)
    )

    val part1 = solve(initialState)
    println(part1)

    val part2 = solve(initialState) { state ->
        state.copy(
            player = state.player.copy(
                hitpoints = state.player.hitpoints - 1
            )
        )
    }
    println(part2)
}

private fun solve(
    initialState: GameState,
    difficultyModifier: (GameState) -> GameState = { it }
): Int {
    val gameStates = Stack<GameState>()
    gameStates.push(initialState)

    var minCostToWin = Integer.MAX_VALUE

    while (!gameStates.empty()) {
        val next = gameStates.pop()
        val playerTurn = next.turn()

        if (playerTurn.boss.dead) {
            minCostToWin = min(minCostToWin, playerTurn.manaSpent)
            continue
        }

        spells
            .filter { it.valid(playerTurn.player, playerTurn.boss) }
            .map { spell -> playerTurn.playerMove(spell) }
            .filter { playerMove -> playerMove.manaSpent < minCostToWin }
            .map(difficultyModifier)
            .map { playerMove -> playerMove.turn() }
            .map { bossTurn -> bossTurn.bossMove() }
            .filterNot { bossMove -> bossMove.player.dead }
            .forEach { gameStates.push(it) }
    }

    return minCostToWin
}

