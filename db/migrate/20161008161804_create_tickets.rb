class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.belongs_to :customer, index: true
      t.belongs_to :agent, index: true
      t.string :title
      t.text :content
      t.string :state # ['New', 'Open', 'Pending', 'Solved', 'Closed']
      t.timestamps
    end
  end
end
