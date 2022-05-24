class Product < ApplicationRecord
  before_create :code_generate
  belongs_to :shipping_company, optional: true
  enum status: {waiting_for_order: 0, waiting_for_shipping_company: 1, sent: 2, delivered: 3}, _default: :waiting_for_order

  validates :customer_name, :customer_address, :distance , :weight, presence: true 
  validates :height, :width, :depth, presence: true
  validates :height, :width, :depth, :weight, :distance, numericality: {only_integer: true}
  validates :height, :width, :depth, :weight, :distance, comparison: { greater_than: 0 }

  private
  def code_generate
    self.code = SecureRandom.alphanumeric(15)
    code_generate if Product.exists?(code: self.code)
  end
end
