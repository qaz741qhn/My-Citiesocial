class Product < ApplicationRecord
  belongs_to :vendor
  validates :code, uniqueness: true
  validates :name, presence: true
  validates :list_price, :sell_price, numericality: { grater_than: 0, allow_nil: true }

  extend FriendlyId
  friendly_id :code_generator, use: :slugged, slug_column: :code

  private

  def code_generator
    SecureRandom.hex(5)
  end
end
