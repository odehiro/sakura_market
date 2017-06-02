require 'rails_helper'

RSpec.feature "User pages", type: :request do
  subject { page }
  
  #describe "profile page" do
  #  let(:user) { FactoryGirl.create(:user) }
  #  #user = FactoryGirl.create(:user)
  #  before { visit user_path(user) }

  #  it { should have_content(user.email) }
  #end

  feature "devise#registrations" do
    background { visit new_user_registration_path }

    scenario "項目確認" do
      is_expected.to have_content('Sign up') 
    end

    scenario "一般ユーザー登録"
  end

  feature "#index" do
    scenario "管理者だけが表示できること"
    scenario "登録されているユーザーが表示されること"
  end
  feature "#show" do
    scenario "ログインユーザーの情報が表示されること"
  end
  feature "#edit" do
    scenario "ユーザー情報を更新できること"
  end
  feature "#destroy" do
    scenario "ユーザーを削除できること"
  end
end
