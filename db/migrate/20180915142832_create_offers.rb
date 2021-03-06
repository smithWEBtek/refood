class CreateOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :offers do |t|
      t.integer :giver_id
      t.string :headline
      t.string :location
      t.text :description
      t.string :availability
      t.string :expiration
      t.boolean :fulfilled, :default => false

      t.timestamps
    end
  end
end
