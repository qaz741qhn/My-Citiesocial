class Admin::VendorsController < Admin::BaseController

  before_action :set_vendor, only: [:edit, :update, :destroy]

  def index
    @vendors = Vendor.all
  end

  def new
    @vendor = Vendor.new
  end

  def create
    @vendor = Vendor.new(vendor_params)
    if @vendor.save
      flash.now[:notice] = "已成功新增廠商"
      redirect_to admin_vendors_path
    else
      flash.now[:notice] = "新增失敗"
      render 'new'
    end
  end

  def edit
  end

  def update
    if @vendor.update(vendor_params)
      flash[:notice] = "已成功更新廠商"
      redirect_to edit_admin_vendor_path(@vendor)
    else
      flash.now[:notice] = "更新失敗"
      render 'edit'
    end
  end

  def destroy
    @vendor.update(deleted_at: Time.now)
    flash[:notice] = "已刪除廠商"
    redirect_to admin_vendors_path
  end

  private

  def vendor_params
    params.require(:vendor).permit(:title, :description, :online)
  end

  def set_vendor
    @vendor = Vendor.find(params[:id])
  end

end
