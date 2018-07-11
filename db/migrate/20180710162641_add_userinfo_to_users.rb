class AddUserinfoToUsers < ActiveRecord::Migration[5.2]
  def change
  	change_table :users do |t|
      t.string :user_name
      t.string :user_department
      t.string :user_sex
  	end
  end
end
