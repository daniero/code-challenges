require 'set'

foods = File
  .readlines(ARGV[0] || '../input/21.txt')
  .map { |line|
    ingredients = line[/[a-z ]+(?= \()/].split
    allergens = line[/(?<=\(contains )[a-z, ]+(?=\))/].split(', ')

    [ingredients, allergens]
  }

foods_by_allergen = foods
  .flat_map { |ingredients, allergens|
    allergens.map { |allergen| [allergen, Set[*ingredients]] }
  }
  .group_by(&:first)
  .map { |k, vs| [k, vs.flat_map { |v| v.drop(1) }] }
  .to_h

allergen_candidates = foods_by_allergen.map { |k,vs| [k,vs.reduce(&:&)] }.to_h
all_ingredients = foods.flat_map(&:first).uniq

safe_ingredients = all_ingredients.select { |ingredient|
  allergen_candidates.none? { |_, ingredients| ingredients.include? ingredient }
}

pp safe_ingredients.sum { |ingredient|
  foods.count { |ingredients, _| ingredients.include?(ingredient) }
}
