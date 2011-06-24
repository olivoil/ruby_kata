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
      hash.inject({}) do |h, key_value|
        key, value = key_value
        h[key.to_i] = value
        h
      end
    end
end