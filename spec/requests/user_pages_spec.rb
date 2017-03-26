require 'rails_helper'

RSpec.describe "User pages", type: :request do
  subject { page }
  
  #describe "profile page" do
  #  let(:user) { FactoryGirl.create(:user) }
  #  #user = FactoryGirl.create(:user)
  #  before { visit user_path(user) }

  #  it { should have_content(user.email) }
  #end

  describe "signup page" do
    before { visit new_user_registration_path }

    it { should have_content('Sign up') }
  end
end
