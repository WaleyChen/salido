class BrandsController < ApplicationController
  protect_from_forgery with: :exception

  def create
    brand = Brand.create(name: params[:brand][:name])
    saved = brand.save
    if (!saved)
      @errMsg = brand.errors.messages[:name][0]
      render "new"
      return
    end

    session[:success_msg] = "Added \"#{brand.name}\" successfully."
    redirect_to :action => "manage"
  end

  def index
    @brands = Brand.all.order_by(:name => 'asc')
  end

  def manage
    @successMsg = getSuccessMsg(session)
  end

  def new
  end

  def show
    @brand = Brand.where(:id => params[:id]).first
  end
end