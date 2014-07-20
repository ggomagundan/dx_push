class Api::PushesController < Api::ApplicationController
  require 'gcm'
  def index
    @pushes = Push.all
  end

  def show
    @push = Push.find(params[:id])
  end

  def new
    @push = Push.new
  end

  def create

    gcm = GCM.new(api_key)

    registration_ids= [] # an array of one or more client registration IDs
    Device.where(gcm_type: 1).each do |device|
      registration_ids.push(device.gcm_id)
    end
    options = {data: {title: push_params[:title], msg: push_params[:msg]}, collapse_key: "Magic Day Push"}
    response = gcm.send_notification(registration_ids, options)
    @json_result.object = response

  end

  def edit
    @push = Push.find(params[:id])
  end

  def update
    @push = Push.find(params[:id])
    if @push.update_attributes(params[:push])
      redirect_to [:api, @push], :notice  => "Successfully updated push."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @push = Push.find(params[:id])
    @push.destroy
    redirect_to api_pushes_url, :notice => "Successfully destroyed push."
  end

  private 
  def push_params
    params.require(:push).permit(:gcm_type, :title, :msg)
  end
end
