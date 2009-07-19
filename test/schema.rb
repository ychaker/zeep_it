ActiveRecord::Schema.define(:version => 0) do  
  create_table "zeep_sms", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "raw"
    t.string   "login"
  end
end