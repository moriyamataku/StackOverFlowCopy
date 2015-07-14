class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :votable, polymorphic: true

  def self.has_up_voted?(user)
    find_by(user: user).try(:useful) || false
  end

  def self.has_down_voted?(user)
    find_by(user: user).present? ? !find_by(user: user).useful : false
  end

  def self.vote_point
    where(useful: true).count - where(useful: false).count
  end
end
