class Admin::ProductsController < Admin::BaseController

  before_action :set_product, only: [:edit, :update, :destroy]

  def index
    @products = Product.all.includes(:vendor).page params[:page]
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = "已成功新增商品"
      redirect_to admin_products_path
    else
      flash.now[:notice] = "新增失敗"
      render 'new'
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      flash[:notice] = "已成功更新商品"
      redirect_to edit_admin_product_path(@product)
    else
      flash.now[:notice] = "更新失敗"
      render 'edit'
    end
  end

  def destroy
    @product.update(deleted_at: Time.now)
    flash[:notice] = "已刪除商品"
    redirect_to admin_products_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :vendor_id, :list_price, :sell_price, :on_sell)
  end

  def set_product
    @product = Product.friendly.find(params[:id])
  end

end
