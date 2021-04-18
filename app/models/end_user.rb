class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  attr_accessor :email_or_username
  #email,usernameどちらでもログイン可能に
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if email_or_username = conditions.delete(:email_or_username)
      where(conditions).where(["username = :value OR lower(email) = lower(:value)", { :value => email_or_username }]).first
    else
      where(conditions).first
    end
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :authentication_keys => [:email_or_username]

  has_many :appeals, dependent: :destroy

  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following_users, through: :active_relationships, source: "followed"
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: "follower"

  attachment :profile_image

  validates :username, presence: true
  validates :username, uniqueness: true, if: :username_presence_true?
  validates :name, presence: true

  def username_presence_true?
    if username.present?
      true
    else
      false
    end
  end

end
