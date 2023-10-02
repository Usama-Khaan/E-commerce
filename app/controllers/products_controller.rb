class ProductsController < ApplicationController
  before_action :find_product_id, only: %i[edit show update destroy]

  VALIDATE_DIGIT = /^\d+$/

  def index
    @products = Product.all
    @name_query = params[:name_query]
    min_price = params[:min_price]
    max_price = params[:max_price]

    @products = filter_products_by_name_query(@products, @name_query)
    @products = price_range_filter(@products, min_price, max_price)

    render 'index'
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

  def filter_products_by_name_query(products, name_query)
    return products unless name_query.present?
    products.where('title ILIKE ?', "%#{name_query}%")
  end

  def price_range_filter(scope, min_price, max_price)
    price_types = { min: min_price, max: max_price }
    price_types.each do |type, price|
      next unless price.present? && VALIDATE_DIGIT.match?(price)
      operator = type == :min ? '>=' : '<='
      scope = scope.where("price #{operator} ?", price)
    end
    scope
  end

  def find_product_id
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :description, :product_quantity, :product_stock_quantity, :price, :image)
  end
end
