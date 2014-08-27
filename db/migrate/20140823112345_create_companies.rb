class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :capital_social
      t.string :denomination_social
      t.string :siege_social

      t.timestamps
    end
  end
end
