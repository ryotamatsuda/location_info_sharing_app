class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  attr_accessor :email_or_username

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :authentication_keys => [:email_or_username]

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

  #email,usernameどちらでもログイン可能に
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if email_or_username = conditions.delete(:email_or_username)
      where(conditions).where(["username = :value OR lower(email) = lower(:value)", { :value => email_or_username }]).first
    else
      where(conditions).first
    end
  end

end
