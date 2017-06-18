class Loan < ApplicationRecord
  belongs_to :book
  belongs_to :customer

  validates :customer_id, presence: true
  validates :book_id, presence: true


  before_validation :ended_at_after_created_at, on: :update, if: Proc.new { |l| l.finished? }


  def self.outstanding
    Loan.where(finished_at: nil)
  end

  def finished?
    !!self.finished_at
  end

  def ended_at_after_created_at
    !!(self.finished_at > self.created_at)
  end

end
