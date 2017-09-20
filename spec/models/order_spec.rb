require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  delivery = Delivery.new(Date.today)

  before do
    user.reload

    @order = Order.new(
      name: "User",
      address: "京都府京都市",
      pay_type: "代引き",
      delivery_date: delivery.start_date,
      delivery_timezone: "8-12",
      user_id: 1
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

    #TODO:このテストは必要。必要ならどう書く？カスタムValidates？
    xit "配送日が土日でないこと" do
      @order.delivery_date = "2017-8-26"
      is_expected.not_to be_valid
    end

    it "配送時間帯が選択範囲であること" do
      @order.delivery_timezone = "21-22"
      is_expected.not_to be_valid
    end
  end

  describe ".ship_date?" do
    before do
      @today = Date.new(2017, 8, 28) #月曜日
      @target_day = Date.new(2017, 9, 1)
    end
    
    it "valid" do
      expect(@order.ship_date?(@today, @target_day)).to be_truthy
    end

    it "土日は営業日でないこと" do
      @target_day = Date.new(2017, 9, 2)

      expect(@order.ship_date?(@today, @target_day)).to be_falsey
    end

    it "invalid 配送日が3日後より前は指定範囲外であること" do
      @today = Date.new(2017, 8, 25) #金曜日
      @target_day = Date.new(2017, 8, 29)

      expect(@order.ship_date?(@today, @target_day)).to be_falsey
    end

    it "invalid 配送日が14営業日までであること" do
      @target_day = Date.new(2017, 9, 15)
      expect(@order.ship_date?(@today, @target_day)).to be_truthy

      @target_day = Date.new(2017, 9, 18)
      expect(@order.ship_date?(@today, @target_day)).to be_falsey
    end
  end
end
