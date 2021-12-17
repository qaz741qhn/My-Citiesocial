class Vendor < ApplicationRecord
  paginates_per 5
  acts_as_paranoid

  validates :title, presence: true

  scope :available, -> { where(online: true) }
end
