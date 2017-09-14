require 'rails_helper'

RSpec.feature "History", type: :request do
  subject { page }

  given(:cash1) { FactoryGirl.create(:cash1) }
  given(:user) { FactoryGirl.create(:user) }
  given(:user2) { FactoryGirl.create(:user_to_empty) }
  given(:admin) { FactoryGirl.create(:admin) }
  given(:cart) { FactoryGirl.create(:cart_valid) }
  given(:food) { FactoryGirl.create(:food) }
  given(:line_item) { FactoryGirl.create(:line_item_order) }
  given(:order1) { FactoryGirl.create(:order1) }

  context "一般ユーザーのとき" do
    background do
      user.reload
      cash1.reload
      food.reload
      cart.reload
      order1.reload
      line_item.reload

      visit root_path
      click_link 'ログイン'

      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
      expect(current_path).to eq home_show_path
    end
    
    feature "order#show" do
      scenario '購入履歴画面へ遷移すること'do
        is_expected.to have_link '購入履歴'

        click_link '購入履歴'
        expect(current_path).to eq orders_path
      end

      scenario '自分の購入履歴一覧が表示されること' do
        click_link '購入履歴'

        #save_and_open_page
        is_expected.to have_content '購入履歴'
        is_expected.to have_content '購入日'
        is_expected.to have_content '合計金額'
        is_expected.to have_content 'お届け先'
        is_expected.to have_link '注文詳細'
      end

      scenario '各購入履歴の詳細が表示されること'
    end
  end

  context "管理者のとき" do
    # background do
    #   cash1.reload
    #   food.reload
    #   cart.reload
    #   order1.reload
    #   line_item.reload
    #
    #   visit root_path
    #   click_link 'ログイン'
    #
    #   fill_in 'メールアドレス', with: admin.email
    #   fill_in 'パスワード', with: admin.password
    #   click_button 'ログイン'
    #  
    #   visit food_path(food.id)
    #   click_link 'カートに入れる'
    # end
    #
    # feature "GET /orders" do
    #   scenario "works! (now write some real specs)" do
    #     get orders_path
    #     expect(response).to have_http_status(200)
    #   end
    # end
    #
    # feature "#new" do
    #   context '住所を登録していないユーザー' do
    #     scenario "カートの情報を元に、注文ができること" do
    #       click_button '購入'
    #       is_expected.to have_http_status(200)
    #       is_expected.to have_content "購入画面"
    #       is_expected.to have_field 'Name', with: admin.to_name
    #       is_expected.to have_field 'Address', with: admin.to_address
    #     end
    #   end
    #   context '住所登録済みユーザー' do
    #   end
    # end
    #
    # feature "#show" do
    #   scenario "注文情報が表示されること" do
    #     visit order_path(order1)
    #     is_expected.to have_http_status(200)
    #     #save_and_open_page
    #     is_expected.to have_content "注文情報"
    #     is_expected.to have_content 'User'
    #     is_expected.to have_content '兵庫'
    #     is_expected.to have_content '代引き'
    #
    #     is_expected.to have_content '購入商品'
    #     is_expected.to have_content food.name
    #     is_expected.to have_content food.price
    #   end
    # end
  end
end
