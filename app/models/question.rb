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

  default_scope -> {order(updated_at: :desc).includes(:votes, :tags, :user)}

  scope :active, -> { where("solved IS NULL or solved = ?", false) }
  scope :hot, -> { where("updated_at > ?", Time.now - 2.days).reorder(views_count: :desc) }
  scope :week, -> { where("updated_at > ?", Time.now - 1.week).reorder(views_count: :desc) }
  scope :month, -> { where("updated_at > ?", Time.now - 1.month).reorder(views_count: :desc) }
  scope :unanswered, -> { where(answers_count: nil).reorder(created_at: :asc) }

  scope :search_by_type, -> type {
    defined_search_type = ["active", "hot", "week", "month", "unanswered"]
    send(type.to_s) if defined_search_type.include?(type)
  }
  scope :tagged_with, -> tag {
    question_ids = joins(:tags).where('tags.name = ?', tag).select(:id)
    where(id: question_ids)
  }

  def regist_tags(tag_string)
    tags = tag_string.split(" ").inject([]) do |tags, strTag|
      tags << Tag.find_or_initialize_by(name: strTag)
    end
    self.tags = tags
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

  def get_answers_count
    self.try(:answers_count) || 0
  end

  def get_views_count
    self.try(:views_count) || 0
  end

end
