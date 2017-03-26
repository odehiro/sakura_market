require 'rails_helper'

RSpec.describe User, type: :model do
  it "ユーザの項目 メールアドレス、パスワード、送付先情報（名前、住所）" do
    is_expected.to respond_to(:email)
    is_expected.to respond_to(:encrypted_password)
    is_expected.to respond_to(:to_name)
    is_expected.to respond_to(:to_address)
  end
  
  before { @user = User.new(
    #name: "Example User", 
    email: "user@example.com",
    password: "foobar",
    password_confirmation: "foobar"
    #encrypted_password: Devise::Encryptor.digest(User, 'password')
  ) }

  subject { @user }
  
  #it { should respond_to(:name) }
  it { should respond_to(:email) }

  it { should be_valid }

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end
end
