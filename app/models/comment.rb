class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :poem

  validates :content, presence: true
end
