package net.daniero.utils

import kotlin.math.min

fun <T> combinations(minAmount: Int, maxAmount: Int, itemsToChoose: Collection<T>): Set<List<T>> {
    val max = min(maxAmount, itemsToChoose.size)

    return (minAmount..max)
        .flatMap { amount -> combinations(amount, itemsToChoose) }
        .toSet()
}

fun <T> combinations(amount: Int, items: Collection<T>): Set<List<T>> {
    if (amount == 0) {
        return setOf(emptyList())
    }
    if (amount > items.size) {
        return emptySet()
    }
    if (amount == items.size) {
        return setOf(items.toList())
    }

    return combinations(amount - 1, items.drop(1))
        .flatMap { s ->
            listOf(
                listOf(items.iterator().next()).plus(s)
            )
        }
        .toSet()
        .plus(combinations(amount, items.drop(1)))
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

fun <T> permutations(elements: List<T>): Sequence<List<T>> {
    if (elements.size == 2) {
        return sequenceOf(elements, elements.reversed())
    }
    if (elements.size <= 1) {
        return sequenceOf(elements)
    }

    val firstElement = elements.first()

    return permutations(elements.drop(1))
        .flatMap { subPerm ->
            (0..subPerm.size).asSequence().map { i ->
                subPerm.take(i).plus(firstElement).plus(subPerm.drop(i))
            }
        }
}