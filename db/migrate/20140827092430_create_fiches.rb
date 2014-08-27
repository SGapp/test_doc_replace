class CreateFiches < ActiveRecord::Migration
  def change
    create_table :fiches do |t|
      t.string :denomination_sociale

      t.timestamps
    end
  end
end
