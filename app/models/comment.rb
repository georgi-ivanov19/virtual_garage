class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :car
    validates :content, :user_id, :car_id, presence: true

end