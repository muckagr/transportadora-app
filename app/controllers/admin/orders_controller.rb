class Admin::OrdersController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_product, only: %i[new create]
    before_action :set_order, only: %i[new create]

    def index
        @service_orders = Order.pendente_de_aceite
    end

    def new
        @available_shipping_companies = ShippingCompany.active
    end

    def create
        @shipping_company = ShippingCompany.find(order_params[:shipping_company])
        @order.update(shipping_company: @shipping_company, 
        delivery_time: Order.deadline_calculator(@product, @shipping_company),
        shipping_price: Order.price_calculator(@product, @shipping_company))
        if @order.save
            @product.update(order_id: @order.id)
            @product.waiting_for_shipping_company!
            return redirect_to admin_orders_path, notice: 'Ordem de Serviço gerada com SUCESSO!'
        end
        flash.now[:notice] = 'Falha ao cadastrar!'
        render 'new'
    end
    
    private 
    def order_params
        params.require(:order).permit(:shipping_company, :product_id)
    end

    def set_order
        @order = @order = Order.new()
    end

    def set_product
        @product = Product.find(params[:product_id])
    end
end