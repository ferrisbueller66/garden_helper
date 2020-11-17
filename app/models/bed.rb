class Bed < ApplicationRecord
  has_many :plants
  has_many :users, through: :plants
  has_many :harvests, through: :plants
  accepts_nested_attributes_for :plants, reject_if: :all_blank

  validates :name, presence: true

  scope :medium_soil, -> { where(medium: "soil")}
end