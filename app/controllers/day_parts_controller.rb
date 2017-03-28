class DayPartsController < ApplicationController
  protect_from_forgery with: :exception

  def create
    @location = Location.where(:id => params[:location_id]).first
    @brand = @location.brand
    dayPart = DayPart.create(name: params[:day_part][:name])
    dayPart.location = @location
    saved = dayPart.save
    
    if (!saved)
      @errMsg = dayPart.errors.messages[:name][0]
      @location.dayParts.delete(dayPart)
      render "new"
      return
    end

    session[:success_msg] = "Added \"#{dayPart.name}\" successfully."
    redirect_to :action => "manage", :location_id => @location.id
  end

  def index
    @location = Location.where(:id => params[:location_id]).first
    @brand = @location.brand
    @dayParts = @location.dayParts
  end

  def manage
    @location = Location.where(:id => params[:location_id]).first
    @brand = @location.brand
    @successMsg = getSuccessMsg(session)
  end

  def new
    @location = Location.where(:id => params[:location_id]).first
    @brand = @location.brand
  end
end