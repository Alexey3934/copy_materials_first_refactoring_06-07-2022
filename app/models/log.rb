class Log < ApplicationRecord

  scope :logs, ->{all.order(created_at: :desc)}
end
