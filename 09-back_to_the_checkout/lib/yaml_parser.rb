require 'yaml'

class YAMLParser
  def parse(rules)
    rules = YAML.load_file(rules) || {}
    
    rules.inject({}) do |hash, rule|
      sku, pricing = rule
      hash[sku] = pricing.sort{ |a,b| b.first <=> a.first }
      hash
    end
  end
end