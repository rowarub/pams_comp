class AddManagerIdToPamsAnswer < ActiveRecord::Migration[5.2]
  def change
    add_column :pams_answers, :manager_id, :integer
  end
end
