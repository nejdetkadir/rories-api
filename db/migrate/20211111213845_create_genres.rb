class CreateGenres < ActiveRecord::Migration[6.1]
  def change
    create_table :genres, id: :uuid do |t|
      t.string :name, null: false, default: ""

      t.timestamps
    end
  end
end
