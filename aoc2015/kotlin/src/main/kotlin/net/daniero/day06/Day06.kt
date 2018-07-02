package net.daniero.day06

import java.io.File
import kotlin.math.max

class Grid(width: Int, height: Int) {

    val grid = Array(height) { Array(width) { 0 } }

    fun alter(x1: Int, y1: Int, x2: Int, y2: Int, transform: (Int) -> Int) {
        (y1..y2).forEach { y ->
            val row = grid[y]
            (x1..x2).forEach { x ->
                row[x] = transform.invoke(row[x])
            }
        }
    }
}

private fun solve(instructions: List<String>, interpretation: (String, Int) -> Int): Int {
    val regex = Regex("""(turn on|turn off|toggle) (\d+),(\d+) through (\d+),(\d+)""")
    val grid = Grid(1000, 1000)

    instructions.forEach { instruction ->
        val match = regex.matchEntire(instruction)!!.groupValues.drop(1)
        val action = match.first()
        val (x1, y1, x2, y2) = match.drop(1).map(String::toInt)

        grid.alter(x1, y1, x2, y2) { i ->
            interpretation.invoke(action, i)
        }
    }

    return grid.grid.sumBy { row -> row.sum() }
}

fun main(args: Array<String>) {
    val instructions = File("../input/06.txt").readLines()

    val part1 = solve(instructions) { action, i ->
        when (action) {
            "turn on" -> 1
            "turn off" -> 0
            else -> i xor 1
        }
    }

    println("Part 1: $part1")

    val part2 = solve(instructions) { action, i ->
        when (action) {
            "turn on" -> i + 1
            "turn off" -> max(i - 1, 0)
            else -> i + 2
        }
    }

    println("Part 2: $part2")
}
