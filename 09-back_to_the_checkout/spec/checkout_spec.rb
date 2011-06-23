require 'spec_helper'

describe Checkout do
  let(:pricing) do 
    Pricing.new({ 'A' => {1 => 50, 3 => 130}  , 
                  'B' => {1 => 30, 2 => 45}   , 
                  'C' => {1 => 20}            , 
                  'D' => {1 => 15}            })
  end
  
  let(:checkout) { Checkout.new(pricing) }
  
  describe "individual scans" do
    context "with individual products" do
      specify { checkout.scan('').should == 0 }
      specify { checkout.scan('A').should == 50 }
      specify { checkout.scan('A,B').should == 80 }
      specify { checkout.scan('C,D,B,A').should == 115 }
    end

    context "with repeated products" do
      specify { checkout.scan('A,A').should == 100 }
      specify { checkout.scan('A,A,A').should == 130 }
      specify { checkout.scan('A,A,A,A').should == 180 }
      specify { checkout.scan('A,A,A,A,A').should == 230 }
      specify { checkout.scan('A,A,A,A,A,A').should == 260 }
    end

    context "with combinations of products" do
      specify { checkout.scan('A,A,A,B').should == 160 }
      specify { checkout.scan('A,A,A,B,B').should == 175 }
      specify { checkout.scan('A,A,A,B,B,D').should == 190 }
      specify { checkout.scan('D,A,B,A,B,A').should == 190 }
    end
  end
  
  describe "incremental scans" do
    it "increments total at each scan" do
      checkout.total.should == 0
      checkout.scan('A').should == 50
      checkout.scan('B').should == 80
      checkout.scan('A').should == 130
      checkout.scan('A').should == 160
      checkout.scan('B').should == 175
    end
  end
end