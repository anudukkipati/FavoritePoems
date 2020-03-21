class User < ApplicationRecord
    has_many :poems
    has_many :comments, dependent: :destroy
    has_many :commented_poems, through: :comments, source: :poem

    has_secure_password
    
    validates :name, presence: true
    validates :email, presence: true
    validates :email, uniqueness: true
end
