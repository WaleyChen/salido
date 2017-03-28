class OrderController < ApplicationController
  protect_from_forgery with: :exception

  def show
    @brands = Brand.all.order_by(:name => 'asc')
  end
end