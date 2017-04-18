require 'rails_helper'

RSpec.describe "Home", type: :request do
  subject { page }

  describe "GET /index_pages" do
    before { visit root_path }

    describe "項目確認" do
      it { should have_http_status(200) }
      it { should have_link("サインイン") }
    end

    describe "ヘッダー項目" do
      it { should have_link("さくらマーケット", href: root_path) }
      it { should_not have_link("日記を見る") }
      it { should_not have_link("お買い物") }
      it { should_not have_link("ショッピングカート") }
      it { should have_link("ログイン", href: new_user_session_path) }
    end

    it "サインインボタンクリック" do
      click_on "サインイン"
      expect(current_path).to eq new_user_registration_path
    end
  end

  describe "signup" do
  #  let(:submit) { "" }

  #  it "should not create a user" do
  #    expect { click_button submit }.not_to change(User, :count)
  #  end
  end

  describe "login" do
    before { visit new_user_session_path }

    describe "with invalid information" do
      before { click_button "ログイン" }
      
      it { is_expected.to have_http_status(200) }
      it { is_expected.to have_title('ログイン') }
      it { is_expected.to have_selector('p.alert') }
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      let(:food) { FactoryGirl.create(:food) }
      before do
        food.reload
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        click_button 'ログイン'
      end

      it "ログイン成功してトップページへ遷移していること" do
        is_expected.to have_http_status(:success)
        expect(current_path).to eq home_show_path
      end

      it "商品一覧が表示されていること" do
        #save_and_open_page
        is_expected.to have_content food.name
        is_expected.to have_content food.price
        is_expected.to have_content food.caption
      end
    end
  end
end
