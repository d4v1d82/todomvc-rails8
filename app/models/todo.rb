class Todo < ApplicationRecord
scope :active, -> { where(completed: false) }
scope :completed, -> { where(completed: true) }
end
