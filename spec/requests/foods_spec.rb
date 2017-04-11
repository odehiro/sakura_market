require 'rails_helper'

RSpec.describe "Foods", type: :request do
  # TODO:権限によるテスト
  before do
    User.create(email: 'foo@example.com', password: 'foobar')
  end

  describe "GET /foods" do
    it "works! (now write some real specs)" do
      visit foods_path
      expect(page).to have_http_status(200)
    end
  end

  describe "new/create" do
    it "生鮮食品登録" do
      visit new_food_path
      expect(page).to have_http_status(200)
      fill_in '商品名', with: '大根'
      attach_file '商品画像', "#{Rails.root}/spec/factories/test_image.png"
      fill_in '価格', with: 100
      fill_in '商品説明', with: '聖護院大根。今が旬！'
      expect(page).to have_checked_field('表示')
      fill_in '並び順', with: ''
      expect { click_on '登　録' }.to change(Food, :count).by(1)
      expect(page).to have_content '登録しました。'
      #expect(current_path).to eq show_food_path
    end
  end

  describe "edit/update" do
    it "" do
      visit foods_path
      expect(page).to have_http_status(200)
    end
  end

  describe "delete" do
    it "" do
      visit foods_path
      expect(page).to have_http_status(200)
    end
  end

end
