class Task < ApplicationRecord
  enum status: { todo: 0, in_progress: 1, done: 2 }
  enum priority: { low: 0, medium: 1, high: 2 }
end
