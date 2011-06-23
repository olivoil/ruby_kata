class Pricing
  def initialize(rule)
    @rule = rule
    
    sort_rule!
  end
  
  def sort_rule!
    @rule.each{|sku, pricing| @rule[sku] = pricing.sort{|a,b| b.first <=> a.first}}
  end
  
  def price(sku, qty = 1)
    pricing = @rule[sku]
  
    pricing.inject(0) do |sum, rule| 
      rule_qty, rule_price = rule
      
      bundle_qty = qty / rule_qty
      sum += bundle_qty * rule_price
      
      qty -= (bundle_qty * rule_qty)
      
      sum
    end
  end
end