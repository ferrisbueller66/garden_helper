class Bed < ApplicationRecord
    has_many :plants
    has_many :users, through: :plants
    accepts_nested_attributes_for :plants

    validates :name, presence: true
end
