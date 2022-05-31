class BudgetGenerate < ApplicationRecord
    validates :height, :width, :depth, :weight, presence: true
    validates :height, :width, :depth, :weight, :distance, numericality: {only_integer: true}
    validates :height, :width, :depth, :weight, :distance, comparison: { greater_than: 0 }
    before_validation :check_active_shipping_companyes

    private
    def check_active_shipping_companyes
        errors.add(:base, 'Não existem Transportadoras disponíveis neste momento.') if ShippingCompany.active.empty?
    end
end
