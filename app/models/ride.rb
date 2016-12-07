class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :service
  has_many :user_rides
  has_many :users, through: :user_rides

  validates :user, presence: true
  validates :service, presence: true


  validates :seats_available, if: :number_of_seats?,numericality: { greater_than_or_equal_to: 0,
                                                                    less_than_or_equal_to: :number_of_seats,
                                                                    only_integer: true}
  validates :number_of_seats, numericality: { greater_than_or_equal_to: 0, only_integer: true}
  validates :meeting_location, presence: true
  validates :leave_time, presence: true
  validates :return_time, presence: true
  validates :vehicle, presence: true
  validates :date, presence: true

  validate :date_cannot_be_in_the_past, on: :create
  validate :return_time_cannot_be_before_leave_time



  def date_cannot_be_in_the_past
    if date.present? and date <= Date.today
      errors.add(:date, "can't be today or earlier")
    end

  end

  def return_time_cannot_be_before_leave_time
    if return_time.present? and leave_time.present? and return_time <= leave_time
      errors.add(:return_time, "can't be before leave time")
    end

  end


end
