# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_07_10_162641) do

  create_table "active_admin_comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "managers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_managers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_managers_on_reset_password_token", unique: true
  end

  create_table "pams_answers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "q_001"
    t.integer "q_002"
    t.integer "q_003"
    t.integer "q_004"
    t.integer "q_005"
    t.integer "q_006"
    t.integer "q_007"
    t.integer "q_008"
    t.integer "q_009"
    t.integer "q_010"
    t.integer "q_011"
    t.integer "q_012"
    t.integer "q_013"
    t.integer "q_014"
    t.integer "q_015"
    t.integer "q_016"
    t.integer "q_017"
    t.integer "q_018"
    t.integer "q_019"
    t.integer "q_020"
    t.integer "q_021"
    t.integer "q_022"
    t.integer "q_023"
    t.integer "q_024"
    t.integer "q_025"
    t.integer "q_026"
    t.integer "q_027"
    t.integer "q_028"
    t.integer "q_029"
    t.integer "q_030"
    t.integer "q_031"
    t.integer "q_032"
    t.integer "q_033"
    t.integer "q_034"
    t.integer "q_035"
    t.integer "q_036"
    t.integer "q_037"
    t.integer "q_038"
    t.integer "q_039"
    t.integer "q_040"
    t.integer "q_041"
    t.integer "q_042"
    t.integer "q_043"
    t.integer "q_044"
    t.integer "q_045"
    t.integer "q_046"
    t.integer "q_047"
    t.integer "q_048"
    t.integer "q_049"
    t.integer "q_050"
    t.integer "q_051"
    t.integer "q_052"
    t.integer "q_053"
    t.integer "q_054"
    t.integer "q_055"
    t.integer "q_056"
    t.integer "q_057"
    t.integer "q_058"
    t.integer "q_059"
    t.integer "q_060"
    t.integer "q_061"
    t.integer "q_062"
    t.integer "q_063"
    t.integer "q_064"
    t.integer "q_065"
    t.integer "q_066"
    t.integer "q_067"
    t.integer "q_068"
    t.integer "q_069"
    t.integer "q_070"
    t.integer "q_071"
    t.integer "q_072"
    t.integer "q_073"
    t.integer "q_074"
    t.integer "q_075"
    t.integer "q_076"
    t.integer "q_077"
    t.integer "q_078"
    t.integer "q_079"
    t.integer "q_080"
    t.integer "q_081"
    t.integer "q_082"
    t.integer "q_083"
    t.integer "q_084"
    t.integer "q_085"
    t.integer "q_086"
    t.integer "q_087"
    t.integer "q_088"
    t.integer "q_089"
    t.integer "q_090"
    t.integer "q_091"
    t.integer "q_092"
    t.integer "q_093"
    t.integer "q_094"
    t.integer "q_095"
    t.integer "q_096"
    t.integer "q_097"
    t.integer "q_098"
    t.integer "q_099"
    t.integer "q_100"
    t.integer "q_101"
    t.integer "q_102"
    t.integer "q_103"
    t.integer "q_104"
    t.integer "q_105"
    t.integer "q_106"
    t.integer "q_107"
    t.integer "q_108"
    t.integer "q_109"
    t.integer "q_110"
    t.integer "q_111"
    t.integer "q_112"
    t.integer "q_113"
    t.integer "q_114"
    t.integer "q_115"
    t.integer "q_116"
    t.integer "q_117"
    t.integer "q_118"
    t.integer "q_119"
    t.integer "q_120"
    t.integer "q_121"
    t.integer "q_122"
    t.integer "q_123"
    t.integer "q_124"
    t.integer "q_125"
    t.integer "q_126"
    t.integer "q_127"
    t.integer "q_128"
    t.integer "q_129"
    t.integer "q_130"
    t.integer "q_131"
    t.integer "q_132"
    t.integer "q_133"
    t.integer "q_134"
    t.integer "q_135"
    t.integer "q_136"
    t.integer "q_137"
    t.integer "q_138"
    t.integer "q_139"
    t.integer "q_140"
    t.integer "q_141"
    t.integer "q_142"
    t.integer "q_143"
    t.integer "q_144"
    t.integer "q_145"
    t.integer "q_146"
    t.integer "q_147"
    t.integer "q_148"
    t.integer "q_149"
    t.integer "q_150"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.boolean "fin_flag", default: false, null: false
    t.integer "manager_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_type", default: 0
    t.integer "manager_id"
    t.string "user_name"
    t.string "user_department"
    t.string "user_sex"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
