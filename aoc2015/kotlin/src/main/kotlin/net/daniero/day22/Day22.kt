package net.daniero.day22

import java.util.*
import kotlin.math.max
import kotlin.math.min

const val magicMissileCost = 53
const val magicMissileDmg = 4
const val drainCost = 73
const val drainEffect = 2
const val shieldCost = 113
const val shieldDuration = 6
const val shieldEffect = 7
const val poisonCost = 173
const val poisonDuration = 6
const val poisonEffect = 3
const val rechargeCost = 229
const val rechargeDuration = 5
const val rechargeEffect = 101

data class Character(
    val hitpoints: Int,
    val mana: Int = 0,
    val damage: Int = 0,
    val armor: Int = 0,
    val shieldCounter: Int = 0,
    val poisonCounter: Int = 0,
    val rechargeCounter: Int = 0
) {
    val dead get() = hitpoints <= 0

    fun turn(): Character {
        return this.copy(
            hitpoints = if (poisonCounter > 0) hitpoints - poisonEffect else hitpoints,
            mana = if (rechargeCounter > 0) mana + rechargeEffect else mana,
            armor = if (shieldCounter > 0) shieldEffect else 0,
            shieldCounter = shieldCounter - 1,
            poisonCounter = poisonCounter - 1,
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
    manaCost = magicMissileCost,
    effect = { player, boss ->
        Pair(
            player,
            boss.copy(hitpoints = boss.hitpoints - magicMissileDmg)
        )
    }
)

val drain = Spell(
    manaCost = drainCost,
    effect = { player, boss ->
        Pair(
            player.copy(hitpoints = player.hitpoints + drainEffect),
            boss.copy(hitpoints = boss.hitpoints - drainEffect)
        )
    }
)

val shield = Spell(
    manaCost = shieldCost,
    condition = { player, boss -> player.shieldCounter <= 0 },
    effect = { player, boss ->
        Pair(
            player.copy(shieldCounter = shieldDuration),
            boss
        )
    }
)

val poison = Spell(
    manaCost = poisonCost,
    condition = { _, boss -> boss.poisonCounter <= 0 },
    effect = { player, boss ->
        Pair(
            player,
            boss.copy(poisonCounter = poisonDuration)
        )
    }
)

val recharge = Spell(
    manaCost = rechargeCost,
    condition = { player, boss -> player.rechargeCounter <= 0 },
    effect = { player, boss ->
        Pair(
            player.copy(rechargeCounter = rechargeDuration),
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

    println(solve(initialState))
}

private fun solve(initialState: GameState): Int {
    val gameStates = Stack<GameState>()
    gameStates.push(initialState)

    var minCostToWin = Integer.MAX_VALUE

    while (!gameStates.empty()) {
        val playerTurn = gameStates.pop().turn()

        if (playerTurn.boss.dead) {
            minCostToWin = min(minCostToWin, playerTurn.manaSpent)
            continue
        }

        spells
            .filter { it.valid(playerTurn.player, playerTurn.boss) }
            .map { spell -> playerTurn.playerMove(spell) }
            .filter { playerMove -> playerMove.manaSpent < minCostToWin }
            .map { playerMove -> playerMove.turn() }
            .map { bossTurn -> bossTurn.bossMove() }
            .filterNot { bossMove -> bossMove.player.dead }
            .forEach { gameStates.push(it) }
    }

    return minCostToWin
}

