class Book < ApplicationRecord
  include AASM

  has_many :loans

  before_destroy :can_be_deleted?

  validates :title, presence: true, uniqueness: true
  validates :author, presence: true

  aasm :create_scopes => false do
    state :available, :initial => true
    state :on_loan

    event :start_loan do
      transitions :from => :available, :to => :on_loan, :guard => :can_be_loaned?
    end

    event :finish_loan do
      transitions :from => :on_loan, :to => :available, :guard => :loan_outstanding?
    end
  end

  def can_be_loaned?
    self.loans.where(finished_at: nil).none?
  end

  def self.can_be_loaned
    Book.where("aasm_state = ?", "available")
  end

  def can_be_deleted?
    if self.loan_outstanding?
      errors[:base] << "Cannot delete book whilst loan is still outstanding"
      throw :abort
    end
  end

  def loan_outstanding?
    self.aasm_state == "on_loan"
  end

  def self.loan_outstanding
    Book.where("aasm_state = ?", "on_loan")
  end

  def current_outstanding_loan
    self.loans.where(finished_at: nil).first
  end

  def set_loan_return_time!
    current_loan = self.current_outstanding_loan
    current_loan.finished_at = Time.now
    current_loan.save!
  end

end
