class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :cars, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :email, :username, presence: true, uniqueness: true
  validates_length_of :username, minimum: 3, maximum: 20
  validates :password, presence: true
  after_create :notify_user

  def validate_username
  end

  #send an email upon sign up
  def notify_user
    UserMailer.notify_user(self).deliver
  end
end
