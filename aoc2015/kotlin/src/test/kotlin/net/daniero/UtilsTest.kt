package net.daniero

import org.assertj.core.api.Assertions.assertThat
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Test

class UtilsTest {

    @Test
    fun testCombinations() {
        assertThat(combinations(0, 0, setOf(1, 2, 3))).containsExactly(emptyList())
        assertThat(combinations(5, 3, setOf(1, 2, 3))).isEmpty()
        assertThat(combinations(0, 100, emptyList<Int>())).containsExactly(emptyList())

        assertThat(
            combinations(0, 1, listOf(1, 2, 3))
        ).containsExactlyInAnyOrder(
            emptyList(),
            listOf(1),
            listOf(2),
            listOf(3)
        )

        assertThat(
            combinations(0, 2, listOf(1, 2, 3))
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
            combinations(0, 3, listOf(1, 2, 3))
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
            combinations(0, 8, listOf(1, 2, 3))
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
            combinations(3, 4, listOf(1, 2, 3))
        ).containsExactlyInAnyOrder(
            listOf(1, 2, 3)
        )

        assertThat(
            combinations(1, 2, listOf(1, 2, 3))
        ).containsExactlyInAnyOrder(
            listOf(1),
            listOf(2),
            listOf(3),
            listOf(1, 2),
            listOf(1, 3),
            listOf(2, 3)
        )

        assertThat(
            combinations(2, 3, listOf(1, 2, 3))
        ).containsExactlyInAnyOrder(
            listOf(1, 2),
            listOf(1, 3),
            listOf(2, 3),
            listOf(1, 2, 3)
        )
    }

    @Test
    fun minSets() {
        assertThat(
            combinations(0, listOf(1, 2, 3))
        ).containsExactly(
            emptyList()
        )

        assertThat(
            combinations(1, listOf(1, 2, 3))
        ).containsExactly(
            listOf(1),
            listOf(2),
            listOf(3)
        )

        assertThat(
            combinations(2, listOf(1, 2, 3))
        ).containsExactly(
            listOf(1, 2),
            listOf(1, 3),
            listOf(2, 3)
        )

        assertThat(
            combinations(3, listOf(1, 2, 3))
        ).containsExactly(
            listOf(1, 2, 3)
        )

        assertThat(
            combinations(4, listOf(1, 2, 3))
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