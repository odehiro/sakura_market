require 'rails_helper'

RSpec.describe "IndexPages", type: :request do
  describe "GET /index_pages" do
    before do
      visit root_path
    end

    it "表示確認" do
      expect(page).to have_http_status(200)
      expect(page).to have_content("サインイン")
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
