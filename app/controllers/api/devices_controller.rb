class Api::DevicesController < Api::ApplicationController

  skip_before_filter  :verify_authenticity_token
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


    if Device.where(device_id: device_params[:device_id]).present?
      @device = Device.where(device_id: device_params[:device_id]).first
      @device.gcm_id = device_params[:gcm_id]
      @device.device_type = device_params[:device_type]
      @device.gcm_type = device_params[:gcm_type]
    else
      @device = Device.new(device_params)
    end


    if @device.save
      @json_result.object = @device
      @json_result.msg = "성공하였습니다."
    else
      @json_result.status = false
      @json_result.msg= "다시 시도해주세요."
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

  private 
  def device_params
    params.require(:device).permit(:device_id, :gcm_id, :device_type, :gcm_type)
  end
end
