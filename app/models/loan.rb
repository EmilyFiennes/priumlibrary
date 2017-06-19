class Loan < ApplicationRecord
  belongs_to :book
  belongs_to :customer

  validates :customer_id, presence: true
  validates :book_id, presence: true


  validate :ended_at_after_created_at?, on: :update, if: Proc.new { |l| l.finished_just_now? }


  def self.outstanding
    Loan.where(finished_at: nil)
  end

  def finished?
    !!finished_at
  end

  def finished_just_now?
    finished? && finished_at_changed?
  end

  def ended_at_after_created_at?
    unless !!self.finished_at && (self.finished_at > self.created_at)
      errors.add(:base, "The return date cannot be before the loan start date.")
      return false
    end
  end
end
