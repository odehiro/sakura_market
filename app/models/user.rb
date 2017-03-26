class User < ApplicationRecord
  #attr_reader :email
  attr_accessor :email

  def initialise(attributes = {})
    @email = attributes[:email]
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
