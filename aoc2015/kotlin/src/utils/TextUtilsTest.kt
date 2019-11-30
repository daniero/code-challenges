package utils

/*
import net.daniero.utils.extract
import org.assertj.core.api.Assertions.assertThat
import org.junit.jupiter.api.Test

class TextUtilsTest {
    @Test
    fun extract_one_word_from_text() {
        val result = extract("""(\w+): 182!""", "blink: 182!") { s: String -> s }

        assertThat(result).isEqualTo("blink")
    }

    @Test
    fun extract_one_integer_from_text() {
        val result = extract("""\w+: (\d+)!""", "blink: 182!") { i: Int -> i }

        assertThat(result).isEqualTo(182)
    }

    @Test
    fun extract_a_apir_of_values_from_text() {
        val result = extract("""(\w+): (\d+)!""", "blink: 182!") { s: String, i: Int -> i to s }

        assertThat(result).isEqualTo(182 to "blink")
    }

    @Test
    fun extract_three_values_from_text() {
        val result = extract("(.)(.)(.)", "123") { a: Int, b: Int, c: Int -> listOf(c, b, a) }

        assertThat(result).containsExactly(3, 2, 1)
    }


    @Test
    fun extract_four_values_from_text() {
        val result = extract("(.)(.)(.)(.)", "12x4") { a: Int, b: Int, c: String, d: Int -> "$b$c$d$a" }

        assertThat(result).isEqualTo("2x41")
    }

}*/
