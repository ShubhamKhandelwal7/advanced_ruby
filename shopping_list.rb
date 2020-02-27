class ShoppingList
  attr_accessor :items_list, :total

  def initialize
    @items_list = []
    @total = 0
  end

  def items(&block)
    instance_eval(&block)
  end

  def add(name, quantity)
    item = @items_list.find {|item| item.name == name}
    if item
      item.quantity+= quantity
    else
      @items_list << Item.new(name, quantity)
    end
    @total += quantity
  end
  
#   class << self
#   def total
#     @items_list.
#   end
# end
end

class Item
  attr_accessor :name, :quantity

  def initialize(name, quantity)
    @name = name
    @quantity = quantity
  end
end

sl = ShoppingList.new
sl.items do
  add("Toothpaste",2)
  add("Computer",1)
  add("Toothpaste",1)
  add("Computer",3)
end


p sl.items_list
p  "Total Items: #{sl.total}"