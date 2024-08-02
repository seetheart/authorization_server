class Role < ApplicationRecord
  has_many :permissions
  belongs_to :application
end
