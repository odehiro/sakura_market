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
      expect(current_path).to eq food_path(id: 1)
    end
  end

  describe "food#show" do
    let(:food) { FactoryGirl.create(:food) }
    before { visit food_path(food) }

    it { expect(page).to have_http_status(200) }
  end

  describe "edit/update" do
    subject { page }
    let(:food) { FactoryGirl.create(:food) }
    before { visit edit_food_path(food) }

    describe "page" do
      scenario "表示項目" do
        #save_and_open_page
        is_expected.to have_content "商品情報　更新"
        is_expected.to have_field('商品名', with: 'だいこん')
        is_expected.to have_field('価格', with: 200)
        is_expected.to have_field('商品説明', with: 'みずみずしい大根')
        is_expected.to have_checked_field('表示')
        is_expected.to have_link "Show"
      end
    end

    describe "with valid information" do
      let(:new_name) { "New Name" }
      let(:new_price) { 1500 }
      before do
        fill_in "商品名", with: new_name
        fill_in "価格", with: new_price

        click_button "更　新"
      end

      it { is_expected.to have_content new_name }
      it { is_expected.to have_content new_price }
      it { is_expected.to have_content 'みずみずしい大根' }
      it { is_expected.to have_content '表示 true' }

      specify { expect(food.reload.name).to eq new_name }
      specify { expect(food.reload.price).to eq new_price }
    end
  end

  describe "delete" do
    subject { page }

    describe "should be able to delete another food" do
      let(:food) { FactoryGirl.create(:food) }
      before do
        food.reload
        visit foods_path
      end

      it "food destroy" do
        expect(page).to have_http_status(200) 
        is_expected.to have_link "削除"
        expect { click_link '削除', match: :first }.to change(Food, :count).by(-1)
        expect(page).to have_content '商品を削除しました。'
        expect(current_path).to eq foods_path
      end
    end
  end
end
