def solve(weights, n_groups)
  target_sum = weights.sum / n_groups
  matches = []

  subset_sums = (0..target_sum).map { nil }
  subset_sums[0] = []

  weights.each do |weight|
    target_sum.downto(0) do |sum|
      path = subset_sums[sum]
      next unless path

      new_sum = sum + weight
      next if new_sum > target_sum

      new_path = [*path, weight]
      matches << new_path if new_sum == target_sum

      existing_next_path = subset_sums[new_sum]

      if existing_next_path
        current_product = existing_next_path.reduce(:*)
        new_product = new_path.reduce(:*)
        if new_product < current_product
          subset_sums[new_sum] = new_path
        end
      else
        subset_sums[new_sum] = new_path
      end

    end
  end

  matches.product(*[matches]*(n_groups-1))
    .select { |paths| paths.reduce(:&) == [] }
    .map { |first, *_| first.reduce(:*) }
    .min
end


weights = File.readlines('../input/24.txt').map(&:to_i)

p solve(weights, 3)
p solve(weights, 4)
