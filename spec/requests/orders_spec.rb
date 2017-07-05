require 'rails_helper'

RSpec.feature "Orders", type: :request do
  subject { page }

  given(:user) { FactoryGirl.create(:user) }
  given(:admin) { FactoryGirl.create(:admin) }
  given(:cart) { FactoryGirl.create(:cart_valid) }
  given(:food) { FactoryGirl.create(:food) }
  given(:line_item) { FactoryGirl.create(:line_item_order) }
  given(:order1) { FactoryGirl.create(:order1) }

  context "一般ユーザーのとき" do
    background do
      food.reload
      cart.reload
      order1.reload
      line_item.reload

      visit root_path
      click_link 'ログイン'

      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
    end

    feature "GET /orders" do
      scenario "works! (now write some real specs)" do
        get orders_path
        expect(response).to have_http_status(200)
      end
    end

    feature "#show" do
      scenario "注文情報が表示されること" do
        visit order_path(order1)
        is_expected.to have_http_status(200)
        #save_and_open_page
        is_expected.to have_content "注文情報"
        is_expected.to have_content 'User'
        is_expected.to have_content '兵庫'
        is_expected.to have_content '代引き'

        is_expected.to have_content '購入商品'
        is_expected.to have_content food.name
        is_expected.to have_content food.price
      end
    end
  end

  context "管理者のとき" do
  end
end
