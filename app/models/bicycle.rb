class Bicycle < ApplicationRecord
  has_many :lendings
  validates :number, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true
  enum state: [:aviable, :assigned, :damaged]

  def self.find_by_code(code)
    where(code: code).first
  end


end
