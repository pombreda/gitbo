class CreatePaymentNotifications < ActiveRecord::Migration
  def change
    create_table :payment_notifications do |t|
      t.text :params
      t.boolean :status
      t.string :transaction_id
      t.string :bounty_id

      t.timestamps
    end
  end
end
