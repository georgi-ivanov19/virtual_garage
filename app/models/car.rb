class Car < ApplicationRecord
    belongs_to :user
    has_many :comments
    has_many_attached :images
    validates :make, :model, :description, :transmission, :engine,:user_id, presence: true

   def thumbnail input
    return self.images[input]
   end
#    def small_thumbnail input
#     return self.images[input].variant(resize: '120x68!').processed
#    end

     
end
