class CreateZeepSms < ActiveRecord::Migration #:nodoc:
  def self.up
    create_table :zeep_sms do |t|
      t.string   "raw"
      t.string   "login"
      t.timestamps
    end
  end

  def self.down
    drop_table :zeep_sms
  end
end
