class User < ActiveRecord::Base
    has_many :recipes
    validates :username, :email, :password_digest, presence: true
    validates :username, uniqueness: true
end