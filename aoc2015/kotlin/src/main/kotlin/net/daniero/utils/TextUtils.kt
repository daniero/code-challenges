package net.daniero.utils

internal inline fun <reified In, reified Out> extract(
    pattern: String,
    text: String,
    transform: (In) -> Out
): Out {
    val groupValues = Regex(pattern).matchEntire(text)!!.groupValues
    val inValue = transformMatch<In>(groupValues[1])
    return transform(inValue)
}

internal inline fun <reified In1, reified In2, Out> extract(
    pattern: String,
    text: String,
    transform: (In1, In2) -> Out
): Out {
    val groupValues = Regex(pattern).matchEntire(text)!!.groupValues
    val inValue1 = transformMatch<In1>(groupValues[1])
    val inValue2 = transformMatch<In2>(groupValues[2])
    return transform(inValue1, inValue2)
}

internal inline fun <reified In1, reified In2, reified In3, Out> extract(
    pattern: String,
    text: String,
    transform: (In1, In2, In3) -> Out
): Out {
    val groupValues = Regex(pattern).matchEntire(text)!!.groupValues
    val inValue1 = transformMatch<In1>(groupValues[1])
    val inValue2 = transformMatch<In2>(groupValues[2])
    val inValue3 = transformMatch<In3>(groupValues[3])
    return transform(inValue1, inValue2, inValue3)
}

internal inline fun <reified In1, reified In2, reified In3, reified In4, Out> extract(
    pattern: String,
    text: String,
    transform: (In1, In2, In3, In4) -> Out
): Out {
    val match = Regex(pattern).matchEntire(text)
        ?: throw NullPointerException("Input \"$text\" doesn't match pattern \"$pattern\"")

    val groupValues = match.groupValues
    val inValue1 = transformMatch<In1>(groupValues[1])
    val inValue2 = transformMatch<In2>(groupValues[2])
    val inValue3 = transformMatch<In3>(groupValues[3])
    val inValue4 = transformMatch<In4>(groupValues[4])
    return transform(inValue1, inValue2, inValue3, inValue4)
}

private inline fun <reified T> transformMatch(match: String): T {
    return when (T::class) {
        Int::class -> match.toInt() as T
        String::class -> match as T
        else -> TODO("Transformation to ${T::class}")
    }
}
