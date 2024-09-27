class Todo < ApplicationRecord
scope :pending, -> { where(completed: false) }
end
