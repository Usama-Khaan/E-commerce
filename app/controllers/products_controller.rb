class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = product.find(params[:id])
  end

  def new
    @product = product.new
  end

  def create
    @product = product.create(product_params)
    if @product.save
      flash[:notice] = 'You have successfully logged out.'
      redirect_to product_path(@product)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @product = product.find(params['id'])
  end

  def update
    @product = product.find(params[:id])

    if @product.update!(product_params)
      redirect_to product_path(@product)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product = product.find(params[:id])
    @product.destroy
    redirect_to products_path, status: :see_other
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :product_quantity, :price)
  end
end
