class MenuItemsController < ApplicationController
  protect_from_forgery with: :exception

  def create
    @brand = Brand.where(:id => params[:menu_item][:brand_id]).first
    menuItem = MenuItem.create(name: params[:menu_item][:name])
    menuItem.brand = @brand
    saved = menuItem.save
    if (!saved)
      @errMsg = menuItem.errors.messages[:name][0]
      @brand.menuItems.delete(menuItem)
      render "new"
      return
    end

    session[:success_msg] = "Added \"#{menuItem.name}\" successfully."
    redirect_to :action => "manage", :brand_id => @brand.id
  end

  def edit
    @brand = Brand.where(:id => params[:brand_id]).first
    @menuItem = MenuItem.where(:id => params[:id]).first
    @priceLevels = @brand.priceLevels.order_by(:name => 'asc')
  end

  def index
    @brand = Brand.where(:id => params[:brand_id]).first  
    @menuItems = @brand.menuItems.all.order_by(:name => 'asc')
    @successMsg = getSuccessMsg(session)
  end

  def location_menu_items
    @location = Location.where(:id => params[:location_id]).first
    @brand = @location.brand
    @priceLevelConfig = nil

    if (params[:price_level_config])
      @orderTypeName = params[:price_level_config][:order_type]
      if @orderTypeName.empty?
        return
      end
      @dayPartName = params[:price_level_config][:day_part]
      @priceLevelConfig = @location.priceLevelConfigs.where(:dayPartName => @dayPartName, :orderTypeName => @orderTypeName).first
    end
  end

  def manage
    @brand = Brand.where(:id => params[:brand_id]).first
    @successMsg = getSuccessMsg(session)
  end

  def new
    @brand = Brand.where(:id => params[:brand_id]).first
  end

  def update
    @brand = Brand.where(:id => params[:brand_id]).first
    @menuItem = MenuItem.where(:id => params[:id]).first
    @priceLevels = @brand.priceLevels.order_by(:name => 'asc')

    menuItemPrices = {}
    params[:menuItem].each do |plKey|
      price = params[:menuItem][plKey]
      if (!valid_float?(price))
        @errMsg = "Invalid price given."
        render "edit"
        return
      end

      menuItemPrices[plKey] = price.empty? ?
        nil : price.to_f.round(2)
    end

    @menuItem.prices = menuItemPrices
    @menuItem.save

    session[:success_msg] = "Edited \"#{@menuItem.name}\" successfully."
    redirect_to :action => "index", :brand_id => @brand.id
  end

  def valid_float?(str)
    !!Float(str) rescue false
  end
end