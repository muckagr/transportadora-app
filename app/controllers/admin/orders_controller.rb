class Admin::OrdersController < ApplicationController
    before_action :authenticate_admin!

    def index
        @service_orders = Order.pendente_de_aceite
    end

    def new
        @order = Order.new()
        @product = Product.find(params[:product_id])
        @available_shipping_companyes = ShippingCompany.active
    end

    def create
        @shipping_company = ShippingCompany.find(order_params[:shipping_company])
        @product = Product.find(params[:product_id])
        @order = Order.new()
        @order.shipping_company = @shipping_company
        @order.delivery_time = Order.deadline_calculator(@product, @shipping_company)
        @order.shipping_price = Order.price_calculator(@product, @shipping_company)
        if @order.save
            @product.order_id = @order.id
            @product.waiting_for_shipping_company!
            return redirect_to admin_orders_path, notice: 'Ordem de Serviço gerada com SUCESSO!'
        end
        flash.now[:notice] = 'Falha ao cadastrar!'
        render 'new'
    end

    def order_params
        params.require(:order).permit(:shipping_company, :product_id)
    end
end