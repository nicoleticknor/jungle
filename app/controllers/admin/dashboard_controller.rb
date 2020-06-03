class Admin::DashboardController < Admin::BaseAdminController
  def show
    @product_count = Product.count
    @category_count = Category.count
  end
end
