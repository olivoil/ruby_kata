require 'yaml'

class YAMLParser
  def parse(rules)
    rules = YAML.load_file(rules) || {}
  end
end