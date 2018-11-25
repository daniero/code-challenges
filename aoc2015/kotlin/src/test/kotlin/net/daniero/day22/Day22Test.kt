package net.daniero.day22

import org.junit.jupiter.api.Test

class Day22Test {

    @Test
    fun example1() {
        val fight = GameState(
            player = Character(hitpoints = 10, mana = 250),
            boss = Character(hitpoints = 13, damage = 8)
        )
            .playerMove(poison)!!
            .turn()
            .bossMove()
            .turn()
            .playerMove(magicMissile)!!
            .turn()

        println(fight)
    }
}