class Product < ApplicationRecord
  before_validation :code_generate
  belongs_to :shipping_company, optional: true
  enum status: {waiting_for_order: 0, waiting_for_shipping_company: 1, sent: 2, delivered: 3}, _default: :waiting_for_order

  validates :customer_name, :customer_address, :distance , :weight, :code, presence: true 
  validates :height, :width, :depth, presence: true
  validates :height, :width, :depth, :weight, :distance, numericality: {only_integer: true}
  validates :height, :width, :depth, :weight, :distance, comparison: { greater_than: 0 }
  validates :code, uniqueness: true
  validates :code, length: { is: 15 }

  private
  def code_generate
    if self.code.nil?
      gen_code = SecureRandom.alphanumeric(15).upcase
      if !Product.exists?(code: gen_code)
        self.code = gen_code
      end
    end
  end
end
