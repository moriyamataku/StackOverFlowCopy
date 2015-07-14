class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  def self.has_favorite?(user)
    find_by(user: user).present?
  end
end
