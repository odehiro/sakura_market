require 'rails_helper'

RSpec.describe "Home", type: :request do
  describe "GET /index_pages" do
    before { visit root_path }
    subject { page }

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
  #  before { visit new_user_registration_path }
  #  let(:submit) { "" }

  #  if "should not create a user" do
  #    expect { click_button submit }.not_to change(User, :count)
  #  end
  end
end
