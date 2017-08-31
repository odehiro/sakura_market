require 'rails_helper'

RSpec.describe Shipping, type: :helper do
  describe ".cost" do
    it "5商品ごとに600円追加されること" do
      shipping = Shipping.new(6)
      expect(shipping.cost).to eq 1200
    end
  
    it "5商品以内は600円" do
      shipping = Shipping.new(5)
      expect(shipping.cost).to eq 600
    end
  end
end
