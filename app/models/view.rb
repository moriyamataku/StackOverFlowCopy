class View < ActiveRecord::Base
  belongs_to :user
  belongs_to :question, :counter_cache => true
end
