class Admin::CategoriesController < Admin::BaseController
  before_action :set_category, only: [:edit, :update, :destroy, :sort]

  def index
    @categories = Category.all.order(position: :asc)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "已成功新增分類"
      redirect_to admin_categories_path
    else
      flash.now[:notice] = "新增失敗"
      render 'new'
    end
  end

  def destroy
    @category.destroy
    flash[:notice] = "已刪除分類"
    redirect_to admin_categories_path
  end

  def sort
    @category.insert_at(params[:to].to_i + 1)
    render json: {status: 'OK'}
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
