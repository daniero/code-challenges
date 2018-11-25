package net.daniero.day21

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Test

class Day21Test {

    @Test
    fun exampleBattle() {
        val player = Character(8, 5, 5)
        val boss = Character(12, 7, 2)

        val result = fight(player, boss)

        assertEquals(Result.VICTORY, result)
    }

    @Test
    fun testChooseAtMost() {
        assertEquals(setOf(emptyList<Int>()), chooseAtMost(0, setOf(1, 2, 3)))

        assertEquals(setOf(emptyList<Int>()), chooseAtMost(100, emptyList<Int>()))

        assertEquals(
            setOf(
                emptyList(),
                listOf(1),
                listOf(2),
                listOf(3)
            ),
            chooseAtMost(1, listOf(1, 2, 3))
        )

        assertEquals(
            setOf(
                emptyList(),
                listOf(1),
                listOf(2),
                listOf(3),
                listOf(1, 2),
                listOf(1, 3),
                listOf(2, 3)
            ),
            chooseAtMost(2, listOf(1, 2, 3))
        )

        assertEquals(
            setOf(
                emptyList(),
                listOf(1),
                listOf(2),
                listOf(3),
                listOf(1, 2),
                listOf(1, 3),
                listOf(2, 3),
                listOf(1, 2, 3)
            ),
            chooseAtMost(3, listOf(1, 2, 3))
        )

        assertEquals(
            setOf(
                emptyList(),
                listOf(1),
                listOf(2),
                listOf(3),
                listOf(1, 2),
                listOf(1, 3),
                listOf(2, 3),
                listOf(1, 2, 3)
            ),
            chooseAtMost(8, listOf(1, 2, 3))
        )
    }

    @Test
    fun testProduct() {
        assertEquals(
            emptyList<List<Int>>(),
            product(emptyList<Int>())
        )

        assertEquals(
            listOf(
                listOf(1, 3, 6),
                listOf(2, 3, 6),
                listOf(1, 4, 6),
                listOf(2, 4, 6),
                listOf(1, 5, 6),
                listOf(2, 5, 6),
                listOf(1, 3, 7),
                listOf(2, 3, 7),
                listOf(1, 4, 7),
                listOf(2, 4, 7),
                listOf(1, 5, 7),
                listOf(2, 5, 7)
            ),
            product(
                listOf(1, 2),
                listOf(3, 4, 5),
                listOf(6, 7)
            )
        )
    }
}