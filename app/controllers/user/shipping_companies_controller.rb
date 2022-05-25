class User::ShippingCompaniesController < ApplicationController
    before_action :set_shipping_company, only: [:show, :edit, :update]
    before_action :user_verify, only: [:edit, :update, :show]
    before_action :authenticate_user!
    
    def index
        @shipping_company = current_user.shipping_company
    end

    def show; end

    def edit; end

    def update
        if @shipping_company.update(shipping_company_params)
            if @shipping_company.price_dimensions > 0 && @shipping_company.price_km > 0 && @shipping_company.price_weight > 0 && @shipping_company.deadline_km > 0 && @shipping_company.minimal_price > 0
                @shipping_company.accepted!
            else
                @shipping_company.waiting!
            end
            return redirect_to user_shipping_company_path(@shipping_company), notice: 'Transportadora atualizada com SUCESSO!'
        else
            flash.now[:notice] = 'Falha ao atualizar Transportadora!'
            return render 'edit'
        end
    end

    private
    def shipping_company_params
        params.require(:shipping_company).permit(:price_dimensions, :price_km, :price_weight, :deadline_km, :minimal_price)
    end

    def set_shipping_company
        @shipping_company = ShippingCompany.find(params[:id])
    end

    def user_verify
        if (current_user.shipping_company.id).to_s != params[:id]
            return redirect_to root_path
        end
    end
end