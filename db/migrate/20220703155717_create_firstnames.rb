class CreateFirstnames < ActiveRecord::Migration[6.1]
  def change
    create_table :firstnames do |t|
      t.string :lastname
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
