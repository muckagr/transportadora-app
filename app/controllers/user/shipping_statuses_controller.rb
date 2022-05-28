class User::ShippingStatusesController < ApplicationController
    before_action :get_order, only: %i[create]
    before_action :authenticate_user!
    before_action :get_shipping_status, only: %i[new]
    def new; end

    def create
        @shipping_status = ShippingStatus.new(shipping_status_params)
        if !@order.nil? && @order.aceita?
            @shipping_status.order_id = get_order.id
        end
        if @shipping_status.save && current_user.shipping_company.id == params[:shipping_company_id].to_i
            return redirect_to root_path, notice: 'Status de Entrega atualizado com sucesso!'
        end
        flash.now[:notice] = 'Falha ao atualizar Status de Entrega!'
        render 'new'
    end

    private
    def shipping_status_params
        params.require(:shipping_status).permit(:status_description, :location, :order_id)
    end

    def get_shipping_status
        @shipping_status = ShippingStatus.new
    end

    def get_order
        @order = Order.find_by(code: params[:shipping_status][:order_id])
    end
end

