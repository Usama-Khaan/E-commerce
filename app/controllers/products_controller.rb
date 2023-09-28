class ProductsController < ApplicationController
  before_action :find_product_id, only: %i[edit show update destroy]
  def index
    @products = Product.all
  end

  def show
  end

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

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to product_path(@product)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    flash[:notice] = 'Product deleted'
    @product.destroy
    redirect_to products_path, status: :see_other
  end

  def search
    @query = params[:query]
    if @query.to_i.to_s == @query
      @products = Product.where('price::text ILIKE ?', "%#{@query}%")
    else
      @products = Product.where('title ILIKE ?', "%#{@query}%")
    end
    render 'index'
  end

  private

  def find_product_id
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :description, :product_quantity, :product_stock_quantity, :price, :image)
  end
end
