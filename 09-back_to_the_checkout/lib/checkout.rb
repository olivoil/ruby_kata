class Checkout
  attr_accessor :pricing
  attr_reader :products
  
  def initialize(pricing)
    @pricing = pricing
    @products = Hash.new(0)
  end
  
  def scan(*skus)
    skus.each do |sku|
      sku.split(',').each do |sku|
        @products[sku] += 1
      end
    end

    self
  end
  
  def total
    @products.inject(0) do |sum, sku_qty| 
      sku, qty = sku_qty
      sum += @pricing.price(sku, qty)
    end
  end
end