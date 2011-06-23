class Checkout
  def initialize(pricing)
    @pricing = pricing
    @products = Hash.new(0)
  end
  
  def price(skus)
    skus.split(//).each { |sku| scan(sku) }
    total
  end
  
  def scan(sku)
    @products[sku] += 1
  end
  
  def total
    @products.inject(0) do |sum, sku_qty| 
      sku, qty = sku_qty
      sum += @pricing.price(sku, qty)
    end
  end
end