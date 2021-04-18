class Appeal < ApplicationRecord

  belongs_to :end_user

  validates :comment, presence: true
  validates :date_and_time, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true

  def add_lat_and_lon_error_message
    self.errors.messages.delete(:latitude)
    self.errors.messages.delete(:longitude)
    self.errors.messages[:pin] = ["を立てて下さい"]
  end
end
