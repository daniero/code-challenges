a, b, c = File.read('../input/16.txt').split("\n\n")

fields = a
  .scan(/([a-z ]+): (\d+)-(\d+) or (\d+)-(\d+)/)
  .map { |name, i,j,k,l| [name, [i.to_i..j.to_i, k.to_i..l.to_i]] }
  .to_h

my_ticket = b.scan(/\d+/).map(&:to_i)

nearby_tickets = c
  .lines
  .drop(1)
  .map { |line| line.scan(/\d+/).map(&:to_i) }


# Part 1

p nearby_tickets
  .flatten
  .select { |value| fields.values.flatten.none? { |field| field.include? value } }
  .sum


# Part 2

valid_tickets = nearby_tickets.select { |ticket|
  ticket.all? { |value|
    fields.values.flatten.any? { |field|
      field.include? value
    }
  }
}

columns = valid_tickets.transpose
candidate_fields_pr_column = columns.map { fields.keys }

columns.each_with_index do |values, i|
  values.each do |value|
    candidate_fields_pr_column[i].reject! { |field|
      fields[field].none? { |range| range.include? value }
    }
  end
end

resolved_fields = columns.map { nil }

until resolved_fields.all?
  next_column = candidate_fields_pr_column.find { |column| column.length == 1 }
  index = candidate_fields_pr_column.index { |column| column.length == 1 }

  next_column = next_column.first

  resolved_fields[index] = next_column
  candidate_fields_pr_column.each { |fields| fields.delete next_column }
end


p resolved_fields.zip(my_ticket)
  .select { |field, _value| field.start_with? 'departure' }
  .transpose.last.reduce(:*)
