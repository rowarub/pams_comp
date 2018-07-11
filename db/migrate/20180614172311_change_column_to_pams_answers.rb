class ChangeColumnToPamsAnswers < ActiveRecord::Migration[5.2]
  def change
    add_column :pams_answers, :fin_flag, :boolean,default: false, null: false
  end
end
