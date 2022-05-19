require 'rails_helper'

describe ShippingCompany do
    it { should validate_presence_of(:email_domain) }
    it { should validate_presence_of(:cnpj) }
    it { should validate_presence_of(:corporate_name) }
    it { should validate_presence_of(:brand_name) }
    it { should validate_length_of(:cnpj).is_equal_to(14) }
    it { should validate_numericality_of(:price_km).is_greater_than_or_equal_to(0)}
    it { should validate_numericality_of(:price_weight).is_greater_than_or_equal_to(0)}
    it { should validate_numericality_of(:price_dimensions).is_greater_than_or_equal_to(0)}
end
