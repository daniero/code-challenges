package net.daniero.day13

import net.daniero.utils.extract
import net.daniero.utils.permutations
import java.io.File

fun main(args: Array<String>) {
    val input = File("../input/13.txt")
        .readLines()
        .map { line ->
            extract(
                """(\w+) would (\w+) (\d+) happiness units by sitting next to (\w+).""",
                line
            ) { personA: String, gainOrLoose: String, happiness: Int, personB: String ->
                val points = if (gainOrLoose == "gain") happiness else -happiness
                (personA to personB) to points
            }
        }
        .toMap()

    val people = input.keys.map { pair -> pair.first }.toSet()

    people.toList()
        .let(::permutations)
        .map { order -> order.plus(order.first()) }
        .map { order ->
            order.windowed(2, 1)
                .sumBy { (a, b) ->
                    input[a to b]!! + input[b to a]!!
                }
        }
        .max()
        .let { println(it) }
}
