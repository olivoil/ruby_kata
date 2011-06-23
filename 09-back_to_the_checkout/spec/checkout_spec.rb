require 'spec_helper'

describe Checkout do
  let(:pricing) do 
    Pricing.new({ 'A' => {1 => 50, 3 => 130}  , 
                  'B' => {1 => 30, 2 => 45}   , 
                  'C' => {1 => 20}            , 
                  'D' => {1 => 15}            })
  end
  
  let(:checkout) { Checkout.new(pricing) }
  
  describe "totals" do
    context "with individual products" do
      specify { checkout.price('').should == 0 }
      specify { checkout.price('A').should == 50 }
      specify { checkout.price('AB').should == 80 }
      specify { checkout.price('CDBA').should == 115 }
    end

    context "with repeated products" do
      specify { checkout.price('AA').should == 100 }
      specify { checkout.price('AAA').should == 130 }
      specify { checkout.price('AAAA').should == 180 }
      specify { checkout.price('AAAAA').should == 230 }
      specify { checkout.price('AAAAAA').should == 260 }
    end

    context "with combinations of products" do
      specify { checkout.price('AAAB').should == 160 }
      specify { checkout.price('AAABB').should == 175 }
      specify { checkout.price('AAABBD').should == 190 }
      specify { checkout.price('DABABA').should == 190 }
    end
  end
  
  describe "scan" do
    it "increments totals at each scan" do
      checkout.total.should == 0
      checkout.price('A').should == 50
      checkout.price('B').should == 80
      checkout.price('A').should == 130
      checkout.price('A').should == 160
      checkout.price('B').should == 175
    end
  end
end