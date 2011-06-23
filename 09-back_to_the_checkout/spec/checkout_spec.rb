require 'spec_helper'

describe Checkout do
  
  # parsers #parse method must return rules in the following format
  hash_rules = {'A' => {1 => 50, 3 => 130}, 'B' => {1 => 30, 2 => 45}, 'C' => {1 => 20}, 'D' => {1 => 15}}   
  
  parsers = { HashParser => hash_rules, YAMLParser => File.join(File.dirname(__FILE__), '..', 'bin', 'rules.yml') }

  parsers.each do |parser, rule|
    describe "with #{parser}" do
      let(:pricing) { Pricing.new(parser, rule) }
      let(:checkout) { Checkout.new(pricing) }
    
      describe "individual scans" do
        context "with individual products" do
          specify { checkout.scan('').total.should == 0 }
          specify { checkout.scan('A').total.should == 50 }
          specify { checkout.scan('A,B').total.should == 80 }
          specify { checkout.scan('C,D,B,A').total.should == 115 }
        end

        context "with repeated products" do
          specify { checkout.scan('A,A').total.should == 100 }
          specify { checkout.scan('A,A,A').total.should == 130 }
          specify { checkout.scan('A,A,A,A').total.should == 180 }
          specify { checkout.scan('A,A,A,A,A').total.should == 230 }
          specify { checkout.scan('A,A,A,A,A,A').total.should == 260 }
        end

        context "with combinations of products" do
          specify { checkout.scan('A,A,A,B').total.should == 160 }
          specify { checkout.scan('A,A,A,B,B').total.should == 175 }
          specify { checkout.scan('A,A,A,B,B,D').total.should == 190 }
          specify { checkout.scan('D,A,B,A,B,A').total.should == 190 }
        end
      end

      describe "incremental scans" do
        it "increments total at each scan" do
          checkout.total.should == 0
          checkout.scan('A').total.should == 50
          checkout.scan('B').total.should == 80
          checkout.scan('A').total.should == 130
          checkout.scan('A').total.should == 160
          checkout.scan('B').total.should == 175
        end
      end
    end
  end
end