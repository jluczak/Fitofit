class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.string :start_point, null: false
      t.string :end_point, null: false
      t.float :distance, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
