require 'rails_helper'

describe 'Guest visits home page' do
    it 'and see the product search bar' do

        visit(root_path)
        
        expect(page).to have_field('Código de Rastreio')
        expect(page).to have_content('Rastreio de Produtos')
        expect(page).to have_button('Procurar')
    end
end