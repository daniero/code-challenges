package net.daniero.day22

import java.util.*
import kotlin.math.max
import kotlin.math.min

data class Character(
    val hitpoints: Int,
    val mana: Int = 0,
    val damage: Int = 0,
    val armor: Int = 0,
    val shieldCounter: Int = 0,
    val shieldEffect: Int = 0,
    val poisonCounter: Int = 0,
    val poisonEffect: Int = 0,
    val rechargeCounter: Int = 0,
    val rechargeEffect: Int = 0
) {
    val dead get() = hitpoints <= 0

    fun turn(): Character {
        return this.copy(
            hitpoints = if (poisonCounter > 0) hitpoints - poisonEffect else hitpoints,
            mana = if (rechargeCounter > 0) mana + rechargeEffect else mana,
            armor = if (shieldCounter > 0) shieldEffect else 0,
            shieldEffect = if (shieldCounter > 0) shieldEffect else 0,
            shieldCounter = shieldCounter - 1,
            poisonEffect = if (poisonCounter > 0) poisonEffect else 0,
            poisonCounter = poisonCounter - 1,
            rechargeEffect = if (rechargeCounter > 0) rechargeEffect else 0,
            rechargeCounter = rechargeCounter - 1
        )
    }
}

data class Spell(
    val manaCost: Int = 0,
    private val condition: (player: Character, boss: Character) -> Boolean = { _, _ -> true },
    val effect: (player: Character, boss: Character) -> Pair<Character, Character>
) {
    fun valid(player: Character, boss: Character): Boolean {
        return manaCost <= player.mana && condition(player, boss)
    }
}

val magicMissile = Spell(
    manaCost = 53,
    effect = { player, boss ->
        Pair(
            player,
            boss.copy(hitpoints = boss.hitpoints - 4)
        )
    }
)

val drain = Spell(
    manaCost = 73,
    effect = { player, boss ->
        Pair(
            player.copy(hitpoints = player.hitpoints + 2),
            boss.copy(hitpoints = boss.hitpoints - 2)
        )
    }
)

val shield = Spell(
    manaCost = 113,
    condition = { player, _ -> player.shieldCounter <= 0 },
    effect = { player, boss ->
        Pair(
            player.copy(shieldCounter = 6, shieldEffect = 7),
            boss
        )
    }
)

val poison = Spell(
    manaCost = 173,
    condition = { _, boss -> boss.poisonCounter <= 0 },
    effect = { player, boss ->
        Pair(
            player,
            boss.copy(poisonCounter = 6, poisonEffect = 3)
        )
    }
)

val recharge = Spell(
    manaCost = 229,
    condition = { player, boss -> player.rechargeCounter <= 0 },
    effect = { player, boss ->
        Pair(
            player.copy(rechargeCounter = 5, rechargeEffect = 101),
            boss
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
                hitpoints = player.hitpoints - max(1, boss.damage - player.armor)
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

fun main(args: Array<String>) {
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

