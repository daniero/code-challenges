package net.daniero.day09

import net.daniero.permutations
import java.io.File

fun main(args: Array<String>) {
    val strings = File("../input/09.txt").readLines()
    val regex = Regex("""(\w+) to (\w+) = (\d+)""")

    val distances = strings.flatMap { string ->
        val match = regex.matchEntire(string)!!.groupValues.drop(1)
        val a = match[0]
        val b = match[1]
        val distance = match[2].toInt()
        listOf(a to b to distance, b to a to distance)
    }.toMap()

    val locations = distances.keys.map { it.first }.toSet()

    val search = permutations(locations.toList())
        .map { path ->
            path to path
                .windowed(2, 1)
                .sumBy { (a, b) -> distances[a to b]!! }
        }

    println(search.minBy { it.second })
    println(search.maxBy { it.second })

}
