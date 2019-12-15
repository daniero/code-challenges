Cost = Struct.new(:name, :quantity) do
end

Product = Struct.new(:name, :quantity, :costs) do
end

costs = File
  .readlines('../input/input14.txt')
  .map { |line|
     *cost, product = line.scan(/(\d+) (\w+)/)
     p = Product.new(product[1], product[0].to_i, cost.map { |c| Cost.new(c[1], c[0].to_i )})
     [p.name, p]
}
  .to_h


p requirements = Hash.new(0)
requirements['FUEL'] += 1
p spares = Hash.new(0)
p :loop

while requirements.any? { |n,_| n != 'ORE' }
  name,need = p requirements.find { |n,_| n != 'ORE' }
  requirements.delete(name)
  if spares.has_key?(name)
    spare = spares.delete(name)
    need -= spare
  end

   p make = costs[name]
   div,mod = p need.divmod(make.quantity)
   unless mod == 0
     spares[name]+= make.quantity - mod
     div+=1
   end
   make.costs.each { |cost| requirements[cost.name] ||= 0; requirements[cost.name] += cost.quantity * div }
end

p :loopend
p requirements
p spares
