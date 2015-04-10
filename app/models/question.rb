class Question < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :tags
  has_many :answers
  has_many :comments, as: :commentable
  has_many :votes, as: :votable
  has_many :views
  has_many :favorites

  paginates_per 7

  validates :title, :body, presence: true

  scope :tab, -> type {
    if type == "hot"
      where("updated_at > ?", Time.now - 2.days).order(views_count: :desc)
    elsif type == "week"
      where("updated_at > ?", Time.now - 1.week).order(views_count: :desc)
    elsif type == "month"
      where("updated_at > ?", Time.now - 1.month).order(views_count: :desc)
    elsif type == "unanswered"
      where(answers_count: nil).order(created_at: :asc)
    else
      order(updated_at: :desc)
    end
  }
  scope :tagged_with, -> tag {
    # TODO: 実装する
    # tag join
  }

  def regist_tags(tag_string)
    if self.persisted?
      self.tags.destroy_all
    end
    strTags = tag_string.split(" ")
    strTags.each do |strTag|
      tag = Tag.find_or_initialize_by(name: strTag)
      self.tags << tag
    end
  end

  def regist_view(user)
    self.views.find_or_create_by(user: user)
  end

  def regist_favorite(user)
    self.favorites.find_or_create_by(user: user)
  end

  def cancel_favorite(user)
    favorite = self.favorites.find_by!(user: user)
    favorite.destroy!
  end

  def do_vote(user, useful)
    vote = self.votes.find_or_create_by!(user: user)
    vote.useful = useful
    vote.save
  end

  def cancel_vote(user)
    vote = self.votes.find_by!(user: user)
    vote.destroy!
  end

  def tag_value
    self.tags.map(&:name).join(' ')
  end

  def vote_point
    self.votes.where(useful: true).count - self.votes.where(useful: false).count
  end

  def get_answers_count
    self.try(:answers_count) || 0
  end

  def get_views_count
    self.try(:views_count) || 0
  end

  def has_favorite?(user)
    self.favorites.find_by(user: user).present?
  end

  def has_up_voted?(user)
    (self.votes.find_by(user: user).present?) ? self.votes.find_by(user: user).useful : false
  end

  def has_down_voted?(user)
    (self.votes.find_by(user: user).present?) ? !self.votes.find_by(user: user).useful : false
  end
end
