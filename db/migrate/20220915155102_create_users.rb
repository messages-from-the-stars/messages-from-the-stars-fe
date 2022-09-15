class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :uid
      t.string :token
      t.string :username
    end
  end
end
