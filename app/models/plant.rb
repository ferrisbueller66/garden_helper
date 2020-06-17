class Plant < ApplicationRecord
    belongs_to :user
    belongs_to :bed
    has_many :harvests
    validates :variety, presence: true
end
