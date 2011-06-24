class Pricing
  attr_accessor :parser, :rules
  
  def initialize(rules, parser = nil)
    @parser = parser ? parser.new : nil
    @rules  = sort_rules(@parser ? @parser.parse(rules) : rules)
  end
  
  def price(sku, qty = 1)
    deals         = @rules[sku]
    remaining_qty = qty
  
    deals.inject(0) do |sum, deal|
      sku_qty, deal_total = find_best_qty_for(remaining_qty, deal)
      remaining_qty -= sku_qty
      sum += deal_total
    end
  end

  private
    def find_best_qty_for desired_qty, deal
      deal_qty, deal_price = deal
      number_of_deals = desired_qty / deal_qty
      
      [number_of_deals * deal_qty, number_of_deals * deal_price]
    end
    
    def sort_rules(hash)
      hash.inject({}) do |hash, rule|
        sku, pricing = rule
        hash[sku] = pricing.sort{ |a,b| b.first <=> a.first }
        hash
      end
    end
end