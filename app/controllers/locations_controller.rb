class LocationsController < ApplicationController
  protect_from_forgery with: :exception

  def create
    @brand = Brand.where(:id => params[:location][:brand_id]).first
    location = Location.create(name: params[:location][:name])
    location.brand = @brand
    saved = location.save
    if (!saved)
      @errMsg = location.errors.messages[:name][0]
      @brand.locations.delete(location)
      render "new"
      return
    end

    session[:success_msg] = "Added \"#{location.name}\" successfully."
    redirect_to :action => "manage", :brand_id => @brand.id
  end

  def index
    @brand = Brand.where(:id => params[:brand_id]).first
    @locations = @brand.locations.all.order_by(:name => 'asc')
  end

  def manage
    @brand = Brand.where(:id => params[:brand_id]).first
    @successMsg = getSuccessMsg(session)
  end

  def new
    @brand = Brand.where(:id => params[:brand_id]).first
  end

  def show
    @location = Location.where(:id => params[:id]).first
    @brand = @location.brand
  end
end