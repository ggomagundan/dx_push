class Api::DevicesController < ApplicationController
  def index
    @devices = Device.all
  end

  def show
    @device = Device.find(params[:id])
  end

  def new
    @device = Device.new
  end

  def create
    @device = Device.new(params[:device])
    if @device.save
      redirect_to [:api, @device], :notice => "Successfully created device."
    else
      render :action => 'new'
    end
  end

  def edit
    @device = Device.find(params[:id])
  end

  def update
    @device = Device.find(params[:id])
    if @device.update_attributes(params[:device])
      redirect_to [:api, @device], :notice  => "Successfully updated device."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @device = Device.find(params[:id])
    @device.destroy
    redirect_to api_devices_url, :notice => "Successfully destroyed device."
  end
end
