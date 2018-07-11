# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# AdminUser.create!(email: 'admin_01@rejapan', password: 'password01', password_confirmation: 'password01') if Rails.env.development?

Manager.find_or_create_by(id: 1) do |manager|
	manager.email = 'mana01@rejapan'
	manager.password = 'mana01'
end

id_num = (1..100).to_a

email_num = []
1.upto(100) { |n|
  email_num << ('%03d' % n).to_s
}

#テストユーザー100件作成
0.upto(99) { |n|
	User.find_or_create_by(id: "#{id_num[n]}") do |user|
		user.email = "user" + "#{email_num[n]}" + "@rejapan"
		user.password = "user" + "#{email_num[n]}"
		user.manager_id  = 1
	end
}
