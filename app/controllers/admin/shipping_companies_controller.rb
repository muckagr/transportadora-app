class Admin::ShippingCompaniesController < ApplicationController
    before_action :set_shipping_company, only: [:show, :edit, :update]
    before_action :authenticate_admin!
    def index
        @shipping_companies = ShippingCompany.all
    end

    def show; end

    def new
        @shipping_company = ShippingCompany.new()
    end

    def create
        @shipping_company = ShippingCompany.new(shipping_company_params)

        if @shipping_company.save
            return redirect_to admin_shipping_companies_path, notice: 'Transportadora cadastrada com SUCESSO!'
        end
        flash.now[:notice] = 'Falha ao cadastrar!'
        render 'new'
    end

    def edit; end

    def update
        if (shipping_company_params[:status] == "active" || shipping_company_params[:status] == "accepted") && (@shipping_company.price_dimensions <= 0 || @shipping_company.price_km <= 0 || @shipping_company.price_weight <= 0 || @shipping_company.deadline_km <= 0)
            @shipping_company.waiting!
            flash.now[:notice] = 'Transportadora não pode estar ativa ou aceita caso não tenha preços e prazos cadastrados!'
            return render 'edit'
        elsif @shipping_company.update(shipping_company_params)
            return redirect_to admin_shipping_company_path(@shipping_company), notice: 'Transportadora atualizada com SUCESSO!'
        end

        flash.now[:notice] = 'Falha ao alterar informações'
        render 'edit'
    end

    private
    def shipping_company_params
        params.require(:shipping_company).permit(:email_domain, :cnpj, :corporate_name, :brand_name, :full_adress, :status)
    end

    def set_shipping_company
        @shipping_company = ShippingCompany.find(params[:id])
    end
end