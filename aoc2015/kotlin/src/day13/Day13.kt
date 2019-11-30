package day13

import net.daniero.utils.extract
import net.daniero.utils.permutations
import java.io.File

fun main() {
    val howMuchPeopleLikeEachother = File("../input/13.txt")
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

    val people = howMuchPeopleLikeEachother.keys.map { pair -> pair.first }.toSet()

    // Part 1:
    maximizeHappiness(people, howMuchPeopleLikeEachother)
        .let(::println)

    // Part 2:
    maximizeHappiness(
        people.plus("me"),
        howMuchPeopleLikeEachother
            .plus(people.associate { person -> (person to "me") to 0 })
            .plus(people.associate { person -> ("me" to person) to 0 })
    )
        .let(::println)
}

private fun maximizeHappiness(people: Set<String>, happiness: Map<Pair<String, String>, Int>): Int {
    return people.toList()
        .let(::permutations)
        .map { order -> order.plus(order.first()) }
        .map { order ->
            order.windowed(2, 1)
                .sumBy { (a, b) ->
                    happiness[a to b]!! + happiness[b to a]!!
                }
        }
        .max()!!
}
