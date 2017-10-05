require 'rails_helper'

RSpec.feature "Home/Devise", type: :request do
  subject { page }

  feature "home#index(welcome画面)" do
    background { visit root_path }

    scenario "項目確認" do
      is_expected.to have_http_status(200)
      is_expected.to have_link("サインイン")
    end

    scenario "ヘッダー項目" do
      is_expected.to have_link("さくらマーケット", href: root_path)
      is_expected.not_to have_link("日記を見る")
      is_expected.not_to have_link("お買い物")
      is_expected.not_to have_link("ショッピングカート")
      is_expected.to have_link("ログイン", href: new_user_session_path)
    end

    scenario "サインインボタンクリック" do
      click_on "サインイン"
      is_expected.to have_http_status(200)
      expect(current_path).to eq new_user_registration_path
    end
  end

  feature "devise#sessions/new" do
    let(:user) { FactoryGirl.create(:user) }
    let(:admin) { FactoryGirl.create(:admin) }
    let(:food) { FactoryGirl.create(:food) }
    let(:food2) { FactoryGirl.create(:food2) }

    background { visit new_user_session_path }

    context "一般ユーザー" do
      feature "devise#sessions/create" do
        background { click_button "ログイン" }

        scenario "ログインエラーが表示されること" do
          is_expected.to have_http_status(200)
          is_expected.to have_title('ログイン')
          is_expected.to have_selector('p#alert')
        end
      end

      feature "devise#sessions/new" do
        background do
          user.reload
          food.reload
          food2.reload
          fill_in 'メールアドレス', with: user.email
          fill_in 'パスワード', with: user.password
          click_button 'ログイン'
        end

        scenario "ログイン成功してトップページへ遷移していること" do
          is_expected.to have_http_status(:success)
          expect(current_path).to eq foods_path
        end

        scenario "ヘッダリンクが表示されていること" do
          is_expected.to have_link("さくらマーケット", href: root_path)
          is_expected.to have_link("日記を見る")
          is_expected.to have_link("お買い物")
          #is_expected.to have_link("ショッピングカート")
          is_expected.not_to have_link("ログイン")
          is_expected.to have_link("ログアウト")

          is_expected.not_to have_content "商品管理"
          is_expected.not_to have_content "ユーザー管理"
        end

        scenario "商品一覧が表示されていること" do
          #save_and_open_page
          expect(current_path).to eq foods_path
          is_expected.to have_link food.name
          #is_expected.to have_css("img[src='']")
          is_expected.not_to have_content food.price
          is_expected.not_to have_content food.caption

          is_expected.to have_link food2.name
        end

        # TODO
        scenario "welcome画面へ遷移しても、トップへリダイレクトされること" do
          visit root_path

          expect(current_path).to eq home_show_path
        end
      end
    end

    context "管理者" do
      feature "devise#sessions/new" do
        background do
          admin.reload
          food.reload
          food2.reload
          fill_in 'メールアドレス', with: admin.email
          fill_in 'パスワード', with: admin.password
          click_button 'ログイン'
        end

        scenario "ログイン成功してトップページへ遷移していること" do
          is_expected.to have_http_status(:success)
          expect(current_path).to eq foods_path
        end

        scenario "管理者用のヘッダリンクが表示されていること" do
          is_expected.to have_link("さくらマーケット", href: root_path)
          is_expected.to have_link("日記を見る")
          is_expected.to have_link("お買い物")
          #is_expected.to have_link("ショッピングカート")
          is_expected.not_to have_link("ログイン")
          is_expected.to have_link("ログアウト")

          is_expected.to have_content "商品管理"
          is_expected.to have_content "ユーザー管理"
        end

        scenario "商品一覧が表示されていること" do
          is_expected.to have_link food.name
          is_expected.not_to have_content food.price
          is_expected.not_to have_content food.caption

          is_expected.to have_link food2.name
        end
      end
    end
  end
end
