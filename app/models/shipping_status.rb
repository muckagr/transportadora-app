class ShippingStatus < ApplicationRecord
  belongs_to :order
  before_validation :put_nowdate

  validates :location, :status_description, :update_date, presence: true

  private

  def put_nowdate
    self.update_date = Time.now.strftime("%d/%m/%Y %H:%M")
  end
end
