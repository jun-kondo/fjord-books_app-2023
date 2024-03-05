class AddZipcodeAddressSelfIntroduceToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :zip_code, :integer
    add_column :users, :address, :string
    add_column :users, :self_introduction, :text
  end
end
