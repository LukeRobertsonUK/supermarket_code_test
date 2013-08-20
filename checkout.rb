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

  def total
    total = 0
    @pricing_rules.each do |pricing_rule|
      rrp = pricing_rule.item.rrp
      batch_total = case pricing_rule.deal
        when :normal_price
          pricing_rule.item.rrp * @items[pricing_rule.item]
        when :bulk_discount
          if @items[pricing_rule.item] > pricing_rule.number_before_discount_applies
            pricing_rule.item.rrp * @items[pricing_rule.item] * (1 - pricing_rule.discount)
          else
            pricing_rule.item.rrp * @items[pricing_rule.item]
          end
        when :bogof
          if @items[pricing_rule.item].even?
            (pricing_rule.item.rrp * @items[pricing_rule.item])/2
          else
            (pricing_rule.item.rrp * (1 + @items[pricing_rule.item]))/2
          end
        end
        total += batch_total
      end
    total
    end

  end


