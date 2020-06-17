class Harvest < ApplicationRecord
    belongs_to :plant
    validates :weight, :harvest_date, presence: true
end
