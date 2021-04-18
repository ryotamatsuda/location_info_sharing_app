class CreateAppeals < ActiveRecord::Migration[6.0]
  def change
    create_table :appeals do |t|
      t.integer :end_user_id, null: false
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.string :comment
      t.datetime :date_and_time, null: false
      t.timestamps
    end
  end
end
