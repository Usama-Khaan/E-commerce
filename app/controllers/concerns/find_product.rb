module FindProduct
  extend ActiveSupport::Concern

  def find_product
    @product = Product.find(params[:id])
  end
end
