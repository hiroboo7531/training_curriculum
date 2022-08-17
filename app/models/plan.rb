class Plan < ApplicationRecord
  validates :plan, presence: true
  validates :date, presence: true
  # indexファイルのplan、dateフォームが空だと無視、createアクションのredirectへ
end
