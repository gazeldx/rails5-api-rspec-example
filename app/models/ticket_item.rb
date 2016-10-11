class TicketItem < ApplicationRecord
  belongs_to :ticket
  # belongs_to :agent

  # validates :content, presence: true
end
