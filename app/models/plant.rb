class Plant < ApplicationRecord
    belongs_to :user
    belongs_to :bed
    has_many :harvests
    accepts_nested_attributes_for :bed
    validates :variety, presence: true

    #scope: :created_before, ->(time) { where("created_at < ?", time) if time.present? }

    def harvest_status
        unless self.harvests.count == 0
        self.harvested = true
        self.save
        end
    end
end
