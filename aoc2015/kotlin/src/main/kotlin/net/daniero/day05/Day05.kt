package net.daniero.day05

import java.io.File
import kotlin.math.max

interface SequenceValidator {
    fun feed(char: Char)
    fun validate(): Boolean
}

class SequenceValidatorCombiner
private constructor(val validators: Iterable<SequenceValidator>) : SequenceValidator {
    constructor(vararg validators: SequenceValidator) : this(validators.toList())

    override fun feed(char: Char) = validators.forEach { it.feed(char) }
    override fun validate(): Boolean = validators.all { it.validate() }
}

class VowelValidator(private var vowelsNeeded: Int) : SequenceValidator {
    override fun feed(char: Char) {
        if (char in "aeiou") {
            vowelsNeeded -= 1
        }
    }

    override fun validate(): Boolean = vowelsNeeded <= 0
}

class RepeatValidator(val lengthNeeded: Int) : SequenceValidator {
    var previousChar: Char? = null
    var successive: Int = 1
    var max: Int = 0

    override fun feed(char: Char) {
        if (char == previousChar) {
            successive += 1
            max = max(max, successive)
        } else {
            previousChar = char
            successive = 1
        }
    }

    override fun validate(): Boolean = max >= lengthNeeded
}

class IllegalSequenceValidator(val chars: Collection<Char>) : SequenceValidator {
    var buffer = emptyList<Char>()
    var illegalSequenceEncountered = false

    override fun feed(char: Char) {
        if (buffer.size >= chars.size) {
            buffer = buffer.drop(1).plusElement(char)
        } else {
            buffer = buffer.plusElement(char)
        }

        illegalSequenceEncountered = illegalSequenceEncountered || buffer == chars
    }

    override fun validate(): Boolean = !illegalSequenceEncountered
}

fun main(args: Array<String>) {
    val strings = File("../input/05.txt").readLines()

    val part1 = strings.count { string ->
        val validator =
                SequenceValidatorCombiner(
                        VowelValidator(3),
                        RepeatValidator(2),
                        IllegalSequenceValidator("ab".toList()),
                        IllegalSequenceValidator("cd".toList()),
                        IllegalSequenceValidator("pq".toList()),
                        IllegalSequenceValidator("xy".toList()))

        string.forEach(validator::feed)
        validator.validate()
    }

    println("Part 1: $part1")
}
