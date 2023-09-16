class Todo < ApplicationRecord

  enum :status, { not_started: 0, in_progress: 10, done: 20}

  validates :title, presence: true
  validates :title, length: { in: 1..50 }
  validates :description, presence: true
  validates :description, length: { in: 10..500 }
  validates :status, presence: true

end
