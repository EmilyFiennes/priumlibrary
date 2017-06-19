class Loan < ApplicationRecord
  belongs_to :book
  belongs_to :customer

  validates :customer_id, presence: true
  validates :book_id, presence: true

  validate :book_is_available, on: :create

  after_create :update_book_state!

  def self.outstanding
    self.where(finished_at: nil)
  end

  def self.uniq_customers_count
    self.all.map(&:customer_id).uniq.count
  end

  private

  def book_is_available
    errors.add(:book, "Book is not available.") unless book.try(:may_start_loan?)
  end

  def update_book_state!
    book.start_loan!
  end
end
