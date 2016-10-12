class Ticket < ApplicationRecord
  belongs_to :customer
  belongs_to :agent

  has_many :ticket_items, dependent: :destroy

  # validates :title, presence: true
end
