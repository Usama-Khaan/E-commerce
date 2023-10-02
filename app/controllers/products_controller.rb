class ProductsController < ApplicationController
  before_action :find_product_id, only: %i[edit show update destroy]

  def index
    @products = Product.all.page(params[:page])
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

  def search
    @name_query = params[:name_query]
    min_price = params[:min_price]
    max_price = params[:max_price]
    product_scope = Product.all.page(params[:page])

    if @name_query.present?
      product_scope = product_scope.where('title ILIKE ?', "%#{@name_query}%")
    end

    if min_price.present? && VALIDATE_DIGIT.match?(min_price)
      product_scope = filter_by_min_price(product_scope, min_price)
    end

    if max_price.present? && VALIDATE_DIGIT.match?(max_price)
      product_scope = filter_by_max_price(product_scope, max_price)
    end

    @products = product_scope
    render 'index'
  end

  private

  VALIDATE_DIGIT = /^\d+$/

  def filter_by_min_price(scope, min_price)
    scope.where('price >= ?', min_price)
  end

  def filter_by_max_price(scope, max_price)
    scope.where('price <= ?', max_price)
  end

  def find_product_id
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :description, :product_quantity, :product_stock_quantity, :price, :image)
  end
end
