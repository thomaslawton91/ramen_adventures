class Post < ApplicationRecord
    has_many :comments
    has_many :photos
    belongs_to :shop
end
