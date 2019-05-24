class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.string :start_point
      t.string :end_point
      t.float :distance
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
