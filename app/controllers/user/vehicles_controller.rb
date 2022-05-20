class User::VehiclesController < ApplicationController
    before_action :authenticate_user!

    def index
        @vehicles = current_user.shipping_company.vehicles
    end

    def new
        @vehicle = Vehicle.new()
    end

    def create
        @vehicle = Vehicle.new(vehicle_params)
        @vehicle.shipping_company = current_user.shipping_company
        if @vehicle.save
            return redirect_to user_shipping_company_vehicles_path(current_user.shipping_company), notice: 'Veículo cadastrado com SUCESSO!'
        end

        flash.now[:notice] = 'Falha ao cadastrar Veículo!'
        render 'new'
    end

    private
    def vehicle_params
        params.require(:vehicle).permit(:license_plate, :fabrication_year, :car_model, :car_brand, :max_weight)
    end
end