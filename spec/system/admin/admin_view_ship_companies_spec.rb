require 'rails_helper'

describe 'Admin acess shipping companies page' do

    it 'and see theres no shipping company registered' do
        admin = Admin.create(email: 'admin@admin.com.br', password: 'password')

        login_as(admin, :scope => :admin)
        visit(root_path)
        click_on('Transportadoras')

        expect(page).to have_content('Não há Transportadoras cadastradas')
    end

    it 'and see registered shipping companies' do
        admin = Admin.create(email: 'admin@admin.com.br', password: 'password')
        shipping_company = ShippingCompany.create!()

        login_as(admin, :scope => :admin)
        visit(root_path)
        click_on('Transportadoras')
    
    end
end