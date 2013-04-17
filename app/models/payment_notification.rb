class PaymentNotification < ActiveRecord::Base
  attr_accessible :bounty_id, :params, :status, :transaction_id

  belongs_to :bounty
  serialize   :params

  after_create :mark_bounty_as_paid

  private
  def mark_cart_as_purchased
    if status == "Completed"
      bounty.update_attribute(:paid_at, Time.now)
    end
  end


end
