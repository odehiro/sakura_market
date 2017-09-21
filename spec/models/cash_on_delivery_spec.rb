require 'rails_helper'

RSpec.describe CashOnDelivery, type: :model do
  describe ".create" do
    before do
      @cash = CashOnDelivery.new(
        less: 500,
        price: 1000
      )
    end

    describe ".new" do
      it "beforeのデータが作成できること" do
        expect(@cash).to be_valid
      end

      it "less(未満の値)が空白は有効でないこと" do
        @cash.less = nil
        expect(@cash).not_to be_valid
      end

      it "金額が空白は有効でないこと" do
        @cash.price = nil
        expect(@cash).not_to be_valid
      end
    end
  end
end
