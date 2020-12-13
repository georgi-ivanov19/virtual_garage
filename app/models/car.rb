class Car < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many_attached :images, dependent: :destroy
    validates :make, :model, :description, :transmission, :engine, :user_id, presence: true
    validate :image_type
    validates_length_of :make, :model, :transmission, :engine, maximum: 50

    def thumbnail input
        return self.images[input].variant(resize: '600x337.5!').processed
    end

   #validate that there are images attached and they are in either jpeg or png format
    private
    def image_type
    if images.attached? == false
        errors.add(:images, "are missing!")
        end
        images.each do |image|
            if !image.content_type.in?(%('image/jpeg image/png'))
                errors.add(:images, "can only have JPEG or PNG extensions")
            end
        end
    end
end
