class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question, :counter_cache => true
  has_many :comments, as: :commentable
  has_many :votes, as: :votable

  def set_mark
    self.question.answers.each do |answer|
      if answer == self
        answer.marked = true
      else
        answer.marked = false
      end
      answer.save
    end
    self.question.solved = true
    self.question.save
  end

  def cancel_mark
    self.marked = false
    self.save
    self.question.solved = false
    self.question.save
  end

  def do_vote(user, useful)
    votes = self.votes.find_or_create_by!(user: user)
    votes.useful = useful
    votes.save
  end

  def cancel_vote(user)
    vote = self.votes.find_by!(user: user)
    vote.destroy!
  end

  def vote_point
    self.votes.where(useful: true).count - self.votes.where(useful: false).count
  end

  def has_up_voted?(user)
    (self.votes.find_by(user: user).present?)? self.votes.find_by(user: user).useful: false
  end

  def has_down_voted?(user)
    (self.votes.find_by(user: user).present?)? !self.votes.find_by(user: user).useful: false
  end

end
