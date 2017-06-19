class Customer < ApplicationRecord
  has_many :loans
  has_many :books, through: :loans

  before_destroy :can_be_deleted?

  validates :firstname, :lastname, presence: true
  validates :email, presence: true, uniqueness: true


  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  def self.total_having_loans
    Customer.joins(:loans).where("loans.customer_id = customer_id").uniq.count
  end

  private

  def can_be_deleted?
    if self.loans.outstanding.any?
      throw :abort
    end
  end
end
