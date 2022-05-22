class Product < ApplicationRecord
  belongs_to :shipping_company, optional: true
  enum status: {waiting_for_order: 0, waiting_for_shipping_company: 1, sent: 2, delivered: 3}, _default: :waiting_for_order
end
