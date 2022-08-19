class Admin::ProductsController < ApplicationController
    before_action :authenticate_admin!
    
    def index
        @products = Product.waiting_for_order
    end

    def show; end

    def new
        @product = Product.new()
    end

    def create
        @product = Product.new(product_params)

        if @product.save
            return redirect_to admin_products_path, notice: 'Produto cadastrado com SUCESSO!'
        end
        flash.now[:alert] = 'Falha ao cadastrar!'
        render 'new'
    end

    private
    def product_params
        params.require(:product).permit(:weight, :height, :width, :depth, :code, :distance, :customer_address, :customer_name)
    end

    def set_product
        @product = Product.find(params[:id])
    end
end