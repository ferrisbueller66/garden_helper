class Plant < ApplicationRecord
    belongs_to :user
    belongs_to :bed
    has_many :harvests
    accepts_nested_attributes_for :bed
    validates :variety, presence: true
end
