package net.daniero.day06

import java.io.File

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

fun main(args: Array<String>) {
    val regex = Regex("""(turn on|turn off|toggle) (\d+),(\d+) through (\d+),(\d+)""")
    val instructions = File("../input/06.txt").readLines()

    val grid = Grid(1000, 1000)

    instructions.forEach { instruction ->
        val match = regex.matchEntire(instruction)!!.groupValues.drop(1)
        val action = match.first()
        val (x1, y1, x2, y2) = match.drop(1).map(String::toInt)

        grid.alter(x1, y1, x2, y2) { i ->
            when (action) {
                "turn on" -> 1
                "turn off" -> 0
                "toggle" -> i xor 1
                else -> throw IllegalArgumentException("Sorry what?")
            }
        }
    }

    println("Part 1: ${grid.grid.flatten().sum()}")
}
