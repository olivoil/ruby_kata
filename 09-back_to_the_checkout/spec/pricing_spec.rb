require 'spec_helper'

describe Pricing do
  it "prices a single product" do
    pricing = Pricing.new({'A' => {1 => 5}})
    
    pricing.price('A').should == 5
    pricing.price('A', 1).should == 5
    pricing.price('A', 2).should == 10
    pricing.price('A', 13).should == 65
  end
  
  it "prices with the special prices when products are repeated" do
    pricing = Pricing.new('A' => {1 => 5, 2 => 9, 5 => 20})
    
    pricing.price('A').should == 5
    pricing.price('A', 2).should == 9
    pricing.price('A', 5).should == 20
  end
  
  it "finds the cheapest combination of prices for repeated products" do
    pricing = Pricing.new('A' => {1 => 10, 3 => 25, 5 => 30})
    
    pricing.price('A', 6).should == 40
    pricing.price('A', 4).should == 35
    pricing.price('A', 5).should == 30
    pricing.price('A', 12).should == 80
    pricing.price('A', 13).should == 85
  end
end