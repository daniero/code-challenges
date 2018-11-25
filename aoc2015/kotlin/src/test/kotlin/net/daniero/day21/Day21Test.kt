package net.daniero.day21

import org.assertj.core.api.Assertions.assertThat
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
        assertEquals(setOf(emptyList<Int>()), choose(0, 0, setOf(1, 2, 3)))
        assertEquals(emptySet<List<Int>>(), choose(5, 3, setOf(1, 2, 3, 4, 5, 6)))

        assertEquals(setOf(emptyList<Int>()), choose(0, 100, emptyList<Int>()))

        assertThat(
            choose(0, 1, listOf(1, 2, 3))
        ).containsExactlyInAnyOrder(
            emptyList(),
            listOf(1),
            listOf(2),
            listOf(3)
        )

        assertThat(
            choose(0, 2, listOf(1, 2, 3))
        ).containsExactlyInAnyOrder(
            emptyList(),
            listOf(1),
            listOf(2),
            listOf(3),
            listOf(1, 2),
            listOf(1, 3),
            listOf(2, 3)
        )

        assertThat(
            choose(0, 3, listOf(1, 2, 3))
        ).containsExactlyInAnyOrder(
            emptyList(),
            listOf(1),
            listOf(2),
            listOf(3),
            listOf(1, 2),
            listOf(1, 3),
            listOf(2, 3),
            listOf(1, 2, 3)
        )

        assertThat(
            choose(0, 8, listOf(1, 2, 3))
        ).containsExactlyInAnyOrder(
            emptyList(),
            listOf(1),
            listOf(2),
            listOf(3),
            listOf(1, 2),
            listOf(1, 3),
            listOf(2, 3),
            listOf(1, 2, 3)
        )

        assertThat(
            choose(3, 4, listOf(1, 2, 3))
        ).containsExactlyInAnyOrder(
            listOf(1, 2, 3)
        )

        assertThat(
            choose(1, 2, listOf(1, 2, 3))
        ).containsExactlyInAnyOrder(
            listOf(1),
            listOf(2),
            listOf(3),
            listOf(1, 2),
            listOf(1, 3),
            listOf(2, 3)
        )

        assertEquals(
            setOf(
                listOf(1, 2),
                listOf(1, 3),
                listOf(2, 3),
                listOf(1, 2, 3)
            ),
            choose(2, 3, listOf(1, 2, 3))
        )
    }

    @Test
    fun minSets() {
        assertThat(
            subSequences(0, listOf(1, 2, 3))
        ).containsExactly(
            emptyList()
        )

        assertThat(
            subSequences(1, listOf(1, 2, 3))
        ).containsExactly(
            listOf(1),
            listOf(2),
            listOf(3)
        )

        assertThat(
            subSequences(2, listOf(1, 2, 3))
        ).containsExactly(
            listOf(1, 2),
            listOf(1, 3),
            listOf(2, 3)
        )

        assertThat(
            subSequences(3, listOf(1, 2, 3))
        ).containsExactly(
            listOf(1, 2, 3)
        )

        assertThat(
            subSequences(4, listOf(1, 2, 3))
        ).isEmpty()
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