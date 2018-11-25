package net.daniero.day21

import kotlin.math.max

data class Item(val name: String, val cost: Int, val damage: Int, val armor: Int)

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

data class Character(val hitpoints: Int, val damage: Int, val armor: Int) {
    fun with(item: Item) = Character(hitpoints, damage + item.damage, armor + item.armor)

}

val boss = Character(
    hitpoints = 104,
    damage = 8,
    armor = 1
)

enum class Result {
    VICTORY, DEFEAT
}

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

fun <T> chooseAtMost(maxAmount: Int, itemsToChoose: Collection<T>): Set<List<T>> {
    if (maxAmount == 0 || itemsToChoose.isEmpty()) {
        return setOf(emptyList<T>())
    }

    return setOf(emptyList<T>())
        .plus(
            itemsToChoose.withIndex().flatMap { (i, value) ->
                chooseAtMost(
                    maxAmount - 1,
                    itemsToChoose.drop(i + 1)
                ).map { sublist ->
                    listOf(value).plus(sublist)
                }
            })
}

fun <T> product(vararg collections: Collection<T>): Iterable<Collection<T>> {
    return product(collections.toList())
}

private fun <T> product(lists: List<Collection<T>>): List<List<T>> {
    if (lists.isEmpty()) {
        return listOf(emptyList())
    }

    if (lists.size == 1) {
        return lists[0].map { listOf(it) }
    }

    val firstList: Collection<T> = lists[0]
    val rest: List<Collection<T>> = lists.drop(1)

    return product(rest)
        .flatMap { subproduct ->
            firstList.map { firstValue ->
                listOf(firstValue).plus(subproduct)
            }
        }
}

fun main(args: Array<String>) {
    val nakedPlayer = Character(100, 0, 0)

    val itemCombinations = product(
        chooseAtMost(1, weapons),
        chooseAtMost(1, armor),
        chooseAtMost(2, rings)
    ).map { it.flatten() }

    itemCombinations
        .filter { items ->
            val equippedPlayer = items.fold(nakedPlayer) { player, item -> player.with(item) }
            fight(equippedPlayer, boss) == Result.VICTORY
        }
        .minBy { it.sumBy(Item::cost) }
        .let { items ->
            println("Minimum cost to win: ${items!!.sumBy(Item::cost)}")
        }
}

