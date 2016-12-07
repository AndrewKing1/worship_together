class ChurchesController < ApplicationController
  before_action :ensure_user_logged_in , only: [:new,:create,:edit,:update,:destroy]

    def new
	@church = Church.new
	@church.services.build
    end

		def show
			@church = Church.find(params[:id])
		rescue
			flash[:danger] = "Unable"
			redirect_to churches_path
		end


    def create
      @church = Church.new(church_params)
      @church.user = current_user
      if @church.save
        flash[:success] = "Church created"
        redirect_to @church
      else
        flash.now[:danger] = "Unable"
        render 'new'
      end
    end

		def index
      #@user = User.find(params[:user_id])
      @churches = Church.all
    end

		def edit
			@church = Church.find(params[:id])
    rescue
      flash[:danger] = "Unable to find church"
      redirect_to churches_path

		end

    def update
      @church = Church.find(params[:id])
      if @church.update(church_params)
        flash[:success] = "Church edited"
        redirect_to @church
      else
        flash[:danger] = "Unable"
        render 'edit'
      end
    end

		def destroy
			@church = Church.find(params[:id])
			if @church.destroy
				flash[:success] = "Church deleted"
				redirect_to @church
			else
				flash[:danger] = "Unable"
				redirect_to @church
			end

		end

    private

    def church_params
	params.require(:church).permit(:name,
				       :web_site,
				       :description,
				       :picture,
				       services_attributes: [ :day_of_week,:start_time,:finish_time,:location ] )
    end

    def ensure_user_logged_in
      unless current_user
        flash[:warning] = 'Not logged in'
        redirect_to login_path
      end
    end


end
