class User::OrdersController < ApplicationController
    before_action :authenticate_user!

    def index
        @service_orders = current_user.shipping_company.orders
    end
end