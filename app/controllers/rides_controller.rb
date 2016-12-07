class RidesController < ApplicationController
    def index
	order_param = (params[:order] || :Date).to_sym
	ordering = case order_param
		   when :Date
		       :date
		   when :Service
		       :service_id
		   end
	@rides = Ride.order(ordering)
			@rides = Ride.all
		end

		def new
			@rides = Ride.new
		end

		def create
			@ride = Ride.new(user_params)
			if @ride.save
				flash[:success] = "Welcome to the site"
				redirect_to @ride
			else
				flash.now[:danger] = "Unable to create new ride"
				render 'new'
			end
		end

		def show
			@rides = Ride.find(params[:id])
		rescue
			flash[:danger] = "Unable to find ride"
			redirect_to rides_path
		end

		def edit
			@ride = Ride.find(params[:id])
		end

		def update
			@ride = Ride.find(params[:id])
			if @ride.update(order_params)
				flash[:success] = "Ride edited"
				redirect_to @ride
			else
				flash[:danger] = "Unable to edit ride"
				render 'edit'
			end
		end

		def destroy
			# Remove the user id from the session
			@ride = Ride.find(params[:id])
			if @ride.destroy
				flash[:success] = "Ride deleted successfully"
				redirect_to rides_path

			else
				flash.now[:danger] = "Unable to delete ride"
				render 'new'
			end
		end




end
