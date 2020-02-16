class Recipe < ActiveRecord::Base
    belongs_to :user
    validates :title, :ingredients, :cook_time, presence: true
end