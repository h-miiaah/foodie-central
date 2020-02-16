class Recipe < ActiveRecord::Base
    belongs_to :user
    validates :title, :instructions, :cook_time, presence: true
end