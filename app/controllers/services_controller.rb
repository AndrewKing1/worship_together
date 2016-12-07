class ServicesController < ApplicationController


  def new
    @service = Service.new

  end

  def show
    @service = Service.find(params[:id])
  rescue
    flash[:danger] = "Unable to find service"
    redirect_to services_path
  end


  def create
    @service = Service.new(service_params)

    if @service.save
      flash[:success] = "Service created"
      redirect_to @service
    else
      flash.now[:danger] = "Unable to create service"
      render 'new'
    end
  end

  def index
    #@user = User.find(params[:user_id])
    @service = Service.all
  end

  def edit
    @service = Service.find(params[:id])

  end

  def update
    @service = Service.find(params[:id])
    if @service.update(service_params)
      flash[:success] = "Service edited"
      redirect_to @service
    else
      flash[:danger] = "Unable to edit service"
      render 'edit'
    end
  end

  def destroy
    @service = Service.find(params[:id])
    if @service.destroy
      flash[:success] = "Service deleted"
      redirect_to @service
    else
      flash[:danger] = "Unable to delete service"
      redirect_to @service
    end

  end

  private

  def service_params
    params.require(:service).permit(:church, :day_of_week,:start_time,:finish_time,:location)
  end

  def ensure_user_logged_in
    unless current_user
      flash[:warning] = 'Not logged in'
      redirect_to login_path
    end
  end
end