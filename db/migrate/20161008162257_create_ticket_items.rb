class CreateTicketItems < ActiveRecord::Migration[5.0]
  def change
    create_table :ticket_items do |t|
      t.belongs_to :ticket, index: true
      t.belongs_to :agent, index: true
      t.text :content
      t.string :state # ['New', 'Open', 'Pending', 'Solved', 'Closed']
      t.timestamps
    end
  end
end
