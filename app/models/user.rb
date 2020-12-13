class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :cars, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :username, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, presence: true, uniqueness: true
  validates_length_of :username, minimum: 3, maximum: 20
  validates :encrypted_password, presence: true
  after_create :notify_user
  after_update :user_edited

  #send an email upon sign up
  def notify_user
    UserMailer.notify_user(self).deliver
  end

  def user_edited
    UserMailer.user_edited(self).deliver
  end
end
