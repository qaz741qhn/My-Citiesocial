class Product < ApplicationRecord
  include CodeGenerator
  paginates_per 5
  acts_as_paranoid

  has_rich_text :description

  belongs_to :vendor
  has_many :skus
  validates :code, uniqueness: true
  validates :name, presence: true
  validates :list_price, :sell_price, numericality: { grater_than: 0, allow_nil: true }

  accepts_nested_attributes_for :skus, reject_if: :all_blank, allow_destroy: true

end
