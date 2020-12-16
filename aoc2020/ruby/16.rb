fields, my_ticket, nearby_tickets = File.read('../input/16.txt').split("\n\n")

valid_fields = fields.scan(/(\d+)-(\d+)/).map { |a,b| (a.to_i)..(b.to_i) }
all_nearby_ticket_values = nearby_tickets.scan(/\d+/).map(&:to_i)

p all_nearby_ticket_values
  .select { |value| valid_fields.none? { |field| field.include? value } }
  .sum
