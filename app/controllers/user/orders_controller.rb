class User::OrdersController < ApplicationController
    before_action :authenticate_user!

    def index
        @service_orders = current_user.shipping_company.orders.where(status: :pendente_de_aceite)
        @vehicles = current_user.shipping_company.vehicles
        @shipping_company = current_user.shipping_company
    end

    def edit; end

    def update
        @order = Order.find(params[:id])
        @product = Product.find_by(order_id: @order)
        if params[:commit] == 'Aceitar Ordem de Serviço'
            @order.update(params.require(:order).permit(:vehicle_id))
            @order.aceita!
            return redirect_to user_shipping_company_orders_path(current_user.shipping_company), notice: 'Ordem de Serviço aceita!'
        elsif params[:commit] == 'Recusar Ordem de Serviço'
            @product.waiting_for_order!
            @order.recusada!
            @product.order_id = nil
            @product.shipping_company = nil
            return redirect_to user_shipping_company_orders_path(current_user.shipping_company), notice: 'Ordem de Serviço recusada!'
        end
    end

    def pending
        @service_orders = current_user.shipping_company.orders.where(status: :aceita)
    end
end