class OrderTypesController < ApplicationController
  protect_from_forgery with: :exception

  def create
    @brand = Brand.where(:id => params[:order_type][:brand_id]).first
    orderType = OrderType.create(name: params[:order_type][:name])
    orderType.brand = @brand
    saved = orderType.save
    if (!saved)
      @errMsg = orderType.errors.messages[:name][0]
      @brand.orderTypes.delete(orderType)
      render "new"
      return
    end

    session[:success_msg] = "Added \"#{orderType.name}\" successfully."
    redirect_to :action => "manage", :brand_id => @brand.id
  end

  def index
    @brand = Brand.where(:id => params[:brand_id]).first
    @orderTypes = @brand.orderTypes.all.order_by(:name => 'asc')
  end

  def manage
    @brand = Brand.where(:id => params[:brand_id]).first
    @successMsg = getSuccessMsg(session)
  end

  def new
    @brand = Brand.where(:id => params[:brand_id]).first
  end
end