class PriceLevelsController < ApplicationController
  protect_from_forgery with: :exception

  def create
    @brand = Brand.where(:id => params[:price_level][:brand_id]).first
    priceLevel = PriceLevel.create(name: params[:price_level][:name])
    priceLevel.brand = @brand
    saved = priceLevel.save
    if (!saved)
      @errMsg = priceLevel.errors.messages[:name][0]
      @brand.priceLevels.delete(priceLevel)
      render "new"
      return
    end

    session[:success_msg] = "Added \"#{priceLevel.name}\" successfully."
    redirect_to :action => "manage_price_levels", :brand_id => @brand.id
  end

  def index
    @brand = Brand.where(:id => params[:brand_id]).first
    @priceLevels = @brand.priceLevels.all.order_by(:name => 'asc')
  end

  def manage_price_levels
    @brand = Brand.where(:id => params[:brand_id]).first
    @successMsg = getSuccessMsg(session)
  end

  def location_price_levels
    @loc = Location.where(:id => params[:location_id]).first
    @brand = @loc.brand

    @errMsg = ""
    if params[:price_level]
      priceLevelConfig = @loc.getPriceLevelConfig(params[:price_level][:id])
      priceLevelConfig.dayPartName = params[:price_level][:day_part]
      priceLevelConfig.orderTypeName = params[:price_level][:order_type]
      saved = priceLevelConfig.save
      if (!saved)
        @errMsg = priceLevelConfig.errors.messages[:save][0]
      end
    end
  end

  def manage
    @brand = Brand.where(:id => params[:brand_id]).first
  end

  def new
    @brand = Brand.where(:id => params[:brand_id]).first
  end
end