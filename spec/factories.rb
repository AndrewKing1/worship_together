FactoryGirl.define do
    factory :user do
	sequence(:name) { |i| "User #{i}" }
	sequence(:email) { |i| "user.#{i}@example.com" }
	password 'password'
	password_confirmation 'password'

	factory :admin do
	    admin true
	end
    end

    factory :church do
      user
      name 'The Holy Church'
      web_site 'Church.com'
	transient { num_services 1 }

	after(:create) do |church, evaluator|
	    create_list(:service, evaluator.num_services, church: church)
	end
    end

    factory :service do
	church
  day_of_week 'Saturday'
  location  "Somewhere casual"
  start_time '19:00'
  finish_time '20:30'
	transient { num_rides 1 }

	after(:create) do |service, evaluator|
	    create_list(:ride, evaluator.num_rides, service: service)
	end
    end

    factory :ride do
      user
      service

      number_of_seats 4
      seats_available 4
			return_time "2000-01-01 10:00:00 UTC"
			leave_time "2000-01-01 04:00:00 UTC"

      meeting_location 'Somewhere casual'
      vehicle 'Ford'
      date '2017-02-04'

	transient { num_riders 1 }

	after(:create) do |ride, evaluator|
	    ride.users = create_list(:user, evaluator.num_riders)
	end
    end

    factory :user_ride do
      user
      ride
    end
end
