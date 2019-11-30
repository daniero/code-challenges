package day21

import net.daniero.utils.combinations
import net.daniero.utils.product
import kotlin.math.max

data class Item(
    val name: String,
    val cost: Int,
    val damage: Int,
    val armor: Int
)

data class Character(
    val hitpoints: Int,
    val damage: Int,
    val armor: Int
) {
    fun with(item: Item) = Character(
        hitpoints,
        damage + item.damage,
        armor + item.armor
    )
}

enum class Result { VICTORY, DEFEAT }

fun fight(player: Character, boss: Character): Result {
    var playerHitpoints = player.hitpoints
    var bossHitpoints = boss.hitpoints

    while (true) {
        bossHitpoints -= max(1, player.damage - boss.armor)
        if (bossHitpoints <= 0) {
            return Result.VICTORY
        }
        playerHitpoints -= max(1, boss.damage - player.armor)
        if (playerHitpoints <= 0) {
            return Result.DEFEAT
        }
    }
}

fun main() {
    val weapons = listOf(
        Item("Dagger", 8, 4, 0),
        Item("Shortsword", 10, 5, 0),
        Item("Warhammer", 25, 6, 0),
        Item("Longsword", 40, 7, 0),
        Item("Greataxe", 74, 8, 0)
    )
    val armor = listOf(
        Item("Leather", 13, 0, 1),
        Item("Chainmail", 31, 0, 2),
        Item("Splintmail", 53, 0, 3),
        Item("Bandedmail", 75, 0, 4),
        Item("Platemail", 102, 0, 5)
    )
    val rings = listOf(
        Item("Damage +1", 25, 1, 0),
        Item("Damage +2", 50, 2, 0),
        Item("Damage +3", 100, 3, 0),
        Item("Defense +1", 20, 0, 1),
        Item("Defense +2", 40, 0, 2),
        Item("Defense +3", 80, 0, 3)
    )

    val nakedPlayer = Character(hitpoints = 100, damage = 0, armor = 0)
    val boss = Character(hitpoints = 104, damage = 8, armor = 1)

    val itemCombinations = product(
        combinations(1, 1, weapons),
        combinations(0, 1, armor),
        combinations(0, 2, rings)
    ).map { it.flatten() }

    val results = itemCombinations
        .groupBy { items ->
            val equippedPlayer = items.fold(nakedPlayer) { player, item -> player.with(item) }
            fight(equippedPlayer, boss)
        }

    results[Result.VICTORY]
        .orEmpty()
        .map { it.sumBy(Item::cost) }
        .min()
        .let { cost ->
            println("Minimum cost to win: $cost")
        }

    results[Result.DEFEAT]
        .orEmpty()
        .map { it.sumBy(Item::cost) }
        .max()
        .let { cost ->
            println("Maximum cost to lose: $cost")
        }
}
