class CreateLoans < ActiveRecord::Migration[5.0]
  def change
    create_table :loans do |t|
      t.references :book, foreign_key: true, index: true
      t.references :customer, foreign_key: true, index: true
      t.datetime :finished_at

      t.timestamps
    end
  end
end
