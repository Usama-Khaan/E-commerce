class ProductsController < ApplicationController
  before_action :find_product, only: %i[edit show update destroy]

  VALIDATE_DIGIT = /^\d+$/

  def index
    @name_query = params[:name_query]
    min_price = params[:min_price]
    max_price = params[:max_price]
    product_scope = Product.all
    product_scope = product_scope.where('title ILIKE ?', "%#{@name_query}%") if @name_query.present?
    @products = filter_by_price_range(product_scope, min_price, max_price)
  end

  def show; end

  def new
    @product = Product.new
  end

  def create
    @product = Product.create(product_params)
    if @product.save
      flash[:notice] = 'Product created'
      redirect_to product_path(@product)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @product.update(product_params)
      redirect_to product_path(@product)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @product.destroy
      flash[:notice] = 'Product deleted'
    else
      flash[:alert] = 'Failed to delete product'
    end
    redirect_to products_path, status: :see_other
  end

  private

  def filter_by_price_range(scope, min_price, max_price)
    scope = scope.where('price >= ?', min_price) if min_price.present? && VALIDATE_DIGIT.match?(min_price)
    scope = scope.where('price <= ?', max_price) if max_price.present? && VALIDATE_DIGIT.match?(max_price)
    scope
  end

  def find_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :description, :product_quantity, :product_stock_quantity, :price, :image)
  end
end
