require 'rails_helper'

describe BudgetGenerate do
  it { should validate_presence_of(:distance) }
  it { should validate_presence_of(:weight) }
  it { should validate_presence_of(:width) }
  it { should validate_presence_of(:height) }
  it { should validate_presence_of(:depth) }
  it { should validate_numericality_of(:distance).is_greater_than(0)}
  it { should validate_numericality_of(:weight).is_greater_than(0)}
  it { should validate_numericality_of(:width).is_greater_than(0)}
  it { should validate_numericality_of(:depth).is_greater_than(0)}
  it { should validate_numericality_of(:height).is_greater_than(0)}

  it 'must have active shipping companies to generate a budget' do
    budget = BudgetGenerate.new(height: 55, depth: 10, width: 15, weight: 2000, distance: 200)

    result = budget.valid?

    expect(result).to be false
  end

  it 'generates a budget if there is active shipping companies' do
    ShippingCompany.create!(email_domain: 'loja99.com', cnpj: '00000000000000', 
            corporate_name: '99 LTDA', brand_name: '99 CENTAVOS', full_adress: 'Rua dos Padres, 101', minimal_price: 30, status: :active)
    budget = BudgetGenerate.new(height: 55, depth: 10, width: 15, weight: 2000, distance: 200)

    result = budget.valid?

    expect(result).to be true
  end
end
