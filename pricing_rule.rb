 class PricingRule
  attr_reader :deal, :item, :number_before_free_item, :number_before_discount_applies, :discount

  def initialize(deal, item, options = {})
    @deal = deal
    @item = item
    @number_before_discount_applies = options[:number_before_discount_applies]
    @discount = options[:discount]
  end

end