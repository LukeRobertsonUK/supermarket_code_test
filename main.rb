require 'pry'
require_relative 'checkout'
require_relative 'item'
require_relative 'pricing_rule'

# items we have for sale
fruit_tea = Item.new(:fr1, "Fruit tea", 311)
strawberries = Item.new(:sr1, "strawberries", 500)
coffee = Item.new(:cf1, "Coffee", 1123)

# store manager can put their pricing rules in here
pricing_rules = [
  PricingRule.new(:bogof, fruit_tea),
  PricingRule.new(:bulk_discount, strawberries, {number_before_discount_applies: 2, discount: 0.1})
]

# load the checkout with the pricing rules
co = Checkout.new(pricing_rules)

# scan the goods
co.scan(strawberries)
co.scan(strawberries)
co.scan(fruit_tea)
co.scan(strawberries)

# get the total
puts co.total

