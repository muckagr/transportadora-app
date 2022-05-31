class CreateBudgetGenerates < ActiveRecord::Migration[7.0]
  def change
    create_table :budget_generates do |t|
      t.integer :height
      t.integer :width
      t.integer :depth
      t.integer :weight
      t.integer :distance

      t.timestamps
    end
  end
end
