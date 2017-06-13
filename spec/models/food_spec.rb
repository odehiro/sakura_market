require 'rails_helper'

RSpec.describe Food, type: :model do
  it "商品の項目 商品名,商品画像,価格（業者を超えても同一価格）,説明文,
    非表示フラグ,表示順" do
    is_expected.to respond_to(:name)
    is_expected.to respond_to(:image)
    is_expected.to respond_to(:price)
    is_expected.to respond_to(:caption)
    is_expected.to respond_to(:display)
    is_expected.to respond_to(:order)
  end

  before do
    #path = Rails.root.join("画像が置いてあるパス")
    #testImage = File.open(path, "rb").read
    @food = Food.new(
      name: "玄米",
      image: "",
      price: 1000,
      caption: "発芽すると栄養豊富",
      display: true
    )
  end

  subject { @food }

  describe ".new" do
    it "beforeのデータが作成可能であること" do
      is_expected.to be_valid
    end

    it "名称が空白は有効でないこと" do
      @food.name = ""
      is_expected.not_to be_valid
    end

    it "金額が空白は有効でないこと" do
      @food.price = ""
      is_expected.not_to be_valid
    end
    
    it "商品説明が空白は有効でないこと" do
      @food.caption = ""
      is_expected.not_to be_valid
    end
    
    it "並び順が自動採番されていること" do
      @food.save
      expect(Food.find(@food.id).order).to eq Food.all.count

      food2 = Food.create(name: "玄米",
                          image: "",
                          price: 1000,
                          caption: "発芽すると栄養豊富",
                          display: true
                         )
      expect(food2.order).to eq 2
    end
  end
end
