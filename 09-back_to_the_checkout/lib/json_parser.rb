require 'json'

class JSONParser
  def parse(json)
    hash = JSON.parse(json)
    numerize_quantities(hash)
  end
  
  private
    def numerize_quantities(hash)
      hash.inject({}) do |result, sku_rules|
        sku, rules = sku_rules
        result[sku] = numerize_hash_keys(rules)
        result
      end
    end
    
    def numerize_hash_keys(hash)
      hash.inject({}) do |h, qty_value|
        qty, value = qty_value
        h[qty.to_i] = value
        h
      end
    end
end