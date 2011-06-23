class HashParser
  def parse(rules)
    rules.inject({}) do |hash, rule|
      sku, pricing = rule
      hash[sku] = pricing.sort{ |a,b| b.first <=> a.first }
      hash
    end    
    # rule.each{|sku, pricing| rule[sku] = pricing.sort{|a,b| b.first <=> a.first}}
  end
end