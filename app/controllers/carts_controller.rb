class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def destroy
    session[:cart_9527] = nil
    flash[:notice] = "購物車已清空"
    redirect_to root_path
  end

  def checkout
  end
end
