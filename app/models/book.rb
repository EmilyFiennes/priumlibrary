class Book < ApplicationRecord
  include AASM

  has_many :loans

  before_destroy :can_be_deleted?

  validates :title, presence: true, uniqueness: true
  validates :author, presence: true

  # aasm state machine gem, all documenation available here: https://github.com/aasm/aasm
  aasm do
    state :available, initial: true
    state :on_loan

    event :start_loan do
      transitions from: :available, to: :on_loan, guard: :available?
    end

    event :finish_loan do
      transitions from: :on_loan, to: :available, guard: :on_loan?, after: :set_loan_return_time!
    end
  end

  def can_be_deleted?
    if on_loan?
      errors[:base] << "Cannot delete book whilst loan is still outstanding"
      throw :abort
    end
  end

  def current_outstanding_loan
    loans.find_by(finished_at: nil)
  end

  def set_loan_return_time!
    current_outstanding_loan.update!(finished_at: Time.now)
  end

end
