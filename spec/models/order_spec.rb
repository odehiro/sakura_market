require 'rails_helper'

RSpec.describe Order, type: :model do
 before do
    @order = Order.new(
      name: "User",
      address: "京都府京都市",
      pay_type: "代引き",
      delivery_date: "2017-8-25",
      delivery_timezone: "8-12"
    )
  end

  subject { @order }

  describe ".new" do
    it "beforeのデータが作成可能であること" do
      is_expected.to be_valid
    end

    it "名前が空白は有効でないこと" do
      @order.name = ""
      is_expected.not_to be_valid
    end

    it "住所が空白は有効でないこと" do
      @order.address = ""
      is_expected.not_to be_valid
    end
    
    it "支払い方法が選択されていること" do
      @order.pay_type = "カード"
      is_expected.not_to be_valid
    end
    it "配送時間帯が選択範囲であること" do
      @order.delivery_timezone = "21-22"
      is_expected.not_to be_valid
    end
  end
end
