require 'pry'
require_relative 'checkout'
require_relative 'item'
require_relative 'pricing_rule'

# items we have for sale
fruit_tea = Item.new(:fr1, "Fruit tea", 311)
strawberries = Item.new(:sr1, "strawberries", 500)
coffee = Item.new(:cf1, "Coffee", 1123)

# I've set it up so we need a pricing rule for each item
# store manager can put their pricing rules in here
pricing_rules = [
  PricingRule.new(:normal_price, coffee),
  PricingRule.new(:bogof, fruit_tea),
  PricingRule.new(:bulk_discount, strawberries, {number_before_discount_applies: 2, discount: 0.1})
]

co = Checkout.new(pricing_rules)

co.scan(fruit_tea)
co.scan(strawberries)
co.scan(fruit_tea)
co.scan(coffee)

puts co.total
