class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :questions
  has_many :answers
  has_many :views
  has_many :favorites

  def user_name
    self.email[0..self.email.index("@") - 1]
  end
end
