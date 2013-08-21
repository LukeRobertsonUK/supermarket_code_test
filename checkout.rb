class Checkout
  attr_reader :pricing_rules, :items
  attr_accessor :total

  def initialize(pricing_rules)
    @pricing_rules = pricing_rules
    @items = {}
  end

  def scan(item)
    @items[item] ? (@items[item] += 1) : (@items[item] = 1)
  end

  def number(item)
    @items[item]
  end

  def rule_for(item)
    @pricing_rules.find{|rule| rule.item == item}
  end

  def sub_total(item)
    item.rrp * number(item)
  end

  def sub_total_bogoff(item)
    number(item).even? ? ( (sub_total(item))/2 ): (item.rrp * (number(item) + 1)/2)
  end

  def sub_total_bulk_discount(item)
    if number(item) > rule_for(item).number_before_discount_applies
      item.rrp * number(item) * (1 - rule_for(item).discount)
    else
      sub_total(item)
    end
  end

  def process_discount(item)
    return case rule_for(item).deal
    when :bogof then sub_total_bogoff(item)
    when :bulk_discount then sub_total_bulk_discount(item)
    end
  end

  def batch_total(item)
    rule_for(item) ? process_discount(item) : sub_total(item)
  end

  def total
    @items.inject(0){ |sum, (item, number)| sum + batch_total(item) }
  end

end


