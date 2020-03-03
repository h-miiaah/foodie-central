class Recipe < ActiveRecord::Base
    belongs_to :user
    belongs_to :category
    validates :title, :instructions, :cook_time, presence: true
end