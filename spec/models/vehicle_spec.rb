require 'rails_helper'

describe Vehicle do
    it { should validate_presence_of(:license_plate) }
    it { should validate_presence_of(:fabrication_year) }
    it { should validate_presence_of(:car_model) }
    it { should validate_presence_of(:car_brand) }
    it { should validate_presence_of(:max_weight) }
    it { should validate_length_of(:license_plate).is_equal_to(7) }
    it { should validate_numericality_of(:max_weight).is_greater_than_or_equal_to(0) }
end