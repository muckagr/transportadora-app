class Admin::BudgetGeneratesController < ApplicationController
    before_action :authenticate_admin!
    
    def show
        @product = BudgetGenerate.find(params[:id])
        @available_shipping_companies = ShippingCompany.active
    end

    def new
        @budget = BudgetGenerate.new()
    end

    def create
        @budget = BudgetGenerate.new(budget_params)

        if @budget.save && !ShippingCompany.active.empty?
            return redirect_to admin_budget_generate_path(@budget), notice: 'Orçamento gerado com SUCESSO!'
        end
        flash.now[:notice] = 'Falha ao realizar orçamento!'
        render 'new'
    end

    private
    def budget_params
        params.require(:budget_generate).permit(:weight, :height, :width, :depth, :distance)
    end
end