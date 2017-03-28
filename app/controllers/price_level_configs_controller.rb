class PriceLevelConfigsController < ApplicationController
  protect_from_forgery with: :exception

  def create
    @location = Location.where(:id => params[:location_id]).first
    @brand = @location.brand
    @plc = PriceLevelConfig.create()
    @plc.location = @location
    @plc.priceLevelName = params[:price_level_config][:price_level_name]
    @plc.dayPartName = params[:price_level_config][:dayPartName]
    @plc.orderTypeName = params[:price_level_config][:orderTypeName]
    saved = @plc.save

    if (!saved)
      @errMsgs = []
      @plc.errors.messages.each do |val|
        @errMsgs << val[1][0]
      end

      @location.priceLevelConfigs.delete(@plc)

      render "edit"
      return
    end

    session[:success_msg] = "Added \"#{@plc.priceLevelName}\" successfully."
    redirect_to :action => "index", :location_id => @location.id
  end

  def edit
    @location = Location.where(:id => params[:location_id]).first
    @brand = @location.brand

    @plc = @location.priceLevelConfigs.where(:priceLevelName => params[:price_level_name]).first
    if !@plc
      @plc = PriceLevelConfig.new
      @plc.priceLevelName = params[:price_level_name]
    end
  end

  def index
    @location = Location.where(:id => params[:location_id]).first
    @brand = @location.brand
    @priceLevelConfigs = @brand.priceLevels
    @successMsg = getSuccessMsg(session)
  end

  def update
    @location = Location.where(:id => params[:location_id]).first
    @brand = @location.brand
    @plc = @location.priceLevelConfigs.where(:id => params[:id]).first
    @plc.dayPartName = params[:price_level_config][:dayPartName]
    @plc.orderTypeName = params[:price_level_config][:orderTypeName]
    saved = @plc.save

    if (!saved)
      @errMsgs = []
      @plc.errors.messages.each do |val|
        @errMsgs << val[1][0]
      end

      render "edit"
      return
    end

    session[:success_msg] = "Edited \"#{@plc.priceLevelName}\" successfully."
    redirect_to :action => "index", :location_id => @location.id
  end
end