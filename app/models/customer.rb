class Customer < ApplicationRecord
  has_many :loans
  has_many :books, through: :loans

  # No dependent destroy because I anticipated it likely that the Library would want to keep a record
  # of passed loans, even if the book or customer has been deleted from the database.
  before_destroy :can_be_deleted?

  validates :firstname, :lastname, presence: true
  validates :email, presence: true, uniqueness: true

  # photo upload via Paperclip gem, full reference available here: https://github.com/thoughtbot/paperclip
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  private

  def can_be_deleted?
    if loans.outstanding.any?
      errors[:base] << "Cannot delete customer whilst loan is still outstanding"
      throw :abort
    end
  end
end
