require 'rails_helper'

RSpec.describe Delivery, type: :helper do
  describe ".start_date" do
    context "平日だけの場合" do 
      it "配送開始日が３営業日からであること" do
        delivery = Delivery.new(Date.new(2017, 9, 4))
        expect(delivery.start_date).to eq Date.new(2017, 9, 7)
      end
    end

    context "土日を挟む場合" do
      it "配送開始日が3営業日からであること" do
        delivery = Delivery.new(Date.new(2017, 9, 8), Date.new(2017, 9, 4))
        expect(delivery.start_date).to eq Date.new(2017, 9, 13)
      end
    end
  end
  
  describe ".end_date" do
    it "配送開始日が14営業日までであること" do
      delivery = Delivery.new(Date.new(2017, 9, 4), Date.new(2017, 9, 4))
      expect(delivery.end_date).to eq Date.new(2017, 9, 22)
    end

    it "配送開始日が14営業日までであること" do
      delivery = Delivery.new(Date.new(2017, 9, 5), Date.new(2017, 9, 4))
      expect(delivery.end_date).to eq Date.new(2017, 9, 25)
    end
  end

  describe ".target_workday?" do
    it "配送指定日が営業日" do
      delivery = Delivery.new(Date.new(2017, 9, 4), Date.new(2017, 9, 7))
      expect(delivery.target_workday?).to eq true
    end
    
    it "配送指定日が土日" do
      delivery = Delivery.new(Date.new(2017, 9, 4), Date.new(2017, 9, 9))
      expect(delivery.target_workday?).to eq false
    end
  end
end
