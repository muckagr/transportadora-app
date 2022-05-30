class HomeController < ApplicationController
    def index

    end

    def search
        @order = Order.find_by(code: params[:order_code])
        if @order.present? && @order.aceita?
            @shipping_statuses = @order.shipping_statuses.order('update_date DESC')
        else
        flash.now[:notice] = 'Produto não encontrado!'
        render 'index'
        end
    end
end