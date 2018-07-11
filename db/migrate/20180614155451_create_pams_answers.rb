class CreatePamsAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :pams_answers do |t|
    1.upto(150) { |n|
      t.integer ('q_' + '%03d' % n).to_sym
    }

      t.timestamps
    end
  end
end
