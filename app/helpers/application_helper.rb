module ApplicationHelper

  def available?(product)
    product.quantity > 0
  end

end
