class Service < ActiveRecord::Base
  day_of_week = {'Sunday' => 1, 'Monday' => 2, 'Tuesday' =>3,
                 'Wednesday' => 4,'Thursday'=>5, 'Friday' => 6,
                 'Saturday' => 7}
  belongs_to :church, inverse_of: :services
  has_many :rides

  validates :church, presence: true
  validates :day_of_week, presence: true
  validates :location, presence: true
  validates :start_time, presence: true
  validates :finish_time, presence: true
end
