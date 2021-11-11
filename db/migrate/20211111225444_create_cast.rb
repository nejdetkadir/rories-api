class CreateCast < ActiveRecord::Migration[6.1]
  def change
    create_table :cast, id: :uuid do |t|
      t.string :fullname, null: false, default: ""
      t.text :biography, null: false, default: ""
      t.string :image, null: false

      t.timestamps
    end
  end
end
