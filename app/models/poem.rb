class Poem < ApplicationRecord
  belongs_to :user

  validates :content, :title, presence: true
end
