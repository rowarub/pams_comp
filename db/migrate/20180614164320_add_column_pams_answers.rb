class AddColumnPamsAnswers < ActiveRecord::Migration[5.2]
  def change
       add_column :pams_answers, :user_id, :integer
  end
end
