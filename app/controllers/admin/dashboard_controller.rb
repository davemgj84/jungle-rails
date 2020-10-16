class Admin::DashboardController < ApplicationController

  # before_filter :authorize

  http_basic_authenticate_with name: ENV["ADMIN_USERNAME"], password: ENV["ADMIN_PW"]

  def show
    @product_count = Product.count
    @category_count = Category.count
  end
end
