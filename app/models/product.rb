class Product < ApplicationRecord
  include CodeGenerator

  belongs_to :vendor
  validates :code, uniqueness: true
  validates :name, presence: true
  validates :list_price, :sell_price, numericality: { grater_than: 0, allow_nil: true }

end
