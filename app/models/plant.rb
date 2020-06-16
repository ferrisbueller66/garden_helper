class Plant < ApplicationRecord
    belongs_to :user
    belongs_to :bed

    validates :variety, presence: true
end
