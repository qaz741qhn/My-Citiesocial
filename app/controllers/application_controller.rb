class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  helper_method :current_cart

  before_action :find_categories, unless: :backend?

  private

  def record_not_found
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end

  def backend?
    controller_path.split('/').first == 'admin'
  end

  def find_categories
    @categories = Category.all.order(position: :asc)
  end

  def current_cart
    @current_cart ||= Cart.from_hash(session[:cart_9527])
  end
end
