class Checkout
  attr_reader :pricing_rules, :items
  attr_accessor :total

  def initialize(pricing_rules)
    @pricing_rules = pricing_rules
    @items = {}
    pricing_rules.each {|rule| @items[rule.item] = 0}
  end

  def scan(item)
    @items[item] += 1
  end

  def quantity(pricing_rule)
    @items[pricing_rule.item]
  end

  def normal_price(pricing_rule)
    pricing_rule.item.rrp
  end


  def total
    total = 0
    @pricing_rules.each do |pricing_rule|
      batch_total = case pricing_rule.deal
        when :bulk_discount
          if quantity(pricing_rule) > pricing_rule.number_before_discount_applies
            normal_price(pricing_rule) * quantity(pricing_rule) * (1 - pricing_rule.discount)
          else
            normal_price(pricing_rule) * quantity(pricing_rule)
          end
        when :bogof
          if quantity(pricing_rule).even?
            (normal_price(pricing_rule) * quantity(pricing_rule))/2
          else
            (normal_price(pricing_rule) * (1+quantity(pricing_rule)))/2
          end
        else
          normal_price(pricing_rule) * quantity(pricing_rule)
        end
        total += batch_total
      end
    total
    end

  end


