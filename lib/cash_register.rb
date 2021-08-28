
#  #void_last_transaction
#    subtracts the last item from the total 
#    returns the total to 0.0 if all items have been removed 

class CashRegister
    #  .new
    #    sets an instance variable @total on initialization to zero 
    #    takes one optional argument, an employee discount, on initialization
    attr_accessor :total, :discount, :last_transaction, :items 

    def initialize(discount = 0)
        @total = 0 
        @discount = discount
        @items = []
    end

    #  #add_item: accepts a title, a price and increases the total 
    #    also accepts an optional quantity, doesn't forget about the previous total 
    #  #items: when called with two arguments (title, price) (see quantity.times)
    #      returns an array containing all items that have been added 
    #    when called with three arguments (title, price, quantity)
    #      returns an array containing all items that have been added, including multiples 
    def add_item(title, price, quantity = 1 )
        self.last_transaction = price * quantity 
        self.total += self.last_transaction
        quantity.times do 
            self.items << title 
        end
    end

    #  #apply_discount
    #    when the cash register was initialized with an employee discount
    #      applies the discount to the total price 
    #      returns success message with updated total 
    #      reduces the total 
    #    when the cash register was not initialized with an employee discount
    #      returns a string error message that there is no discount to apply 
    def apply_discount
        if self.discount != 0 
            discount_as_percent = (100.0 - self.discount.to_f) / 100 
            self.total = (self.total * discount_as_percent).to_i 
             "After the discount, the total comes to $#{self.total}."
        else
          "There is no discount to apply."
        end
    end

    #  #void_last_transaction
    #    subtracts the last item from the total 
    #    returns the total to 0.0 if all items have been removed 
    def void_last_transaction
        self.total -= self.last_transaction
    end

end

puts "cash_register"
cash_register = CashRegister.new
puts cash_register.total 
#=> 0 
cash_register.total = 100 
puts cash_register.total
#=> 100

cash_register.add_item("eggs", 0.98)
puts cash_register.total
#=> 100.98

cash_register.add_item("book", 5.00, 3)
puts cash_register.total
#=> 115.98

p cash_register.items
#=> ["eggs", "book", "book", "book"]

puts cash_register.apply_discount
#=> There is no discount to apply.

puts ""
puts "Cash register with discount"
# dicount of 20
cash_register_with_discount = CashRegister.new(20)
puts cash_register_with_discount.total
#=> 0

cash_register_with_discount.add_item("macbookair", 1000)
puts cash_register_with_discount.apply_discount 
#=> After the discount, the total comes to $800.
puts cash_register_with_discount.total
#=> 800

puts ""
puts "new register"
new_register = CashRegister.new 
new_register.add_item("eggs", 1.99)
new_register.add_item("tomato", 1.76)
new_register.add_item("eggs", 1.99, 2)
new_register.add_item("tomato", 1.76, 3)
p new_register.items
#=> ["eggs", "tomato", "eggs", "eggs", "tomato", "tomato", "tomato"]

puts new_register.total
#=> 13.010000000000002

new_register.void_last_transaction
puts new_register.total
#=> 7.730000000000001

