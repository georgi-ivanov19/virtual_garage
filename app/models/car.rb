class Car < ApplicationRecord
    belongs_to :user
    has_many :comments
    has_many_attached :images
    validates :make, :model, :description, :transmission, :engine,:user_id, presence: true
    validate :image_type

   def thumbnail input
    return self.images[input]
   end    

   private
   def image_type
    if images.attached? == false
        errors.add(:images, "are missing!")
        end
        images.each do |image|
            if !image.content_type.in?(%('image/jpeg image/png'))
                errors.add(:images, "can only have JPEG of PNG extensions")
            end
        end
    end
end
