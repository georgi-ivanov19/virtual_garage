class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :cars
  has_many :comments, dependent: :destroy
  validates :email, :username, presence: true
  after_create :notify_user
  
  def notify_user
    UserMailer.notify_user(self).deliver
  end
end
