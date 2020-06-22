class Plant < ApplicationRecord
    belongs_to :user
    belongs_to :bed
    has_many :harvests
    accepts_nested_attributes_for :bed, reject_if: :all_blank
    validates :variety, presence: true

    scope :been_harvested, -> { where(harvested: true) }

    def harvest_status
        unless self.harvests.count == 0
        self.harvested = true
        self.save
        end
    end

    def yield_amount
        if self.harvests.count > 0
            amount = []
            amount << self.harvests.each {|harvest| harvest.weight}
            amount.sum
            binding.pry
        else
            return "0 oz."
        end
    end
end
