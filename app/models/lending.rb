class Lending < ApplicationRecord
  belongs_to :bicycle
  belongs_to :student

  before_validation :check_bicycle_state, :validate_student
  after_save :bike_unaviable
  before_destroy :bike_aviable
  enum state: [:active, :delivered]

  private

  def check_bicycle_state
    errors.add(:bicycle, :invalid, message: "biclycle not aviable") unless bicycle.aviable?
  end

  def bike_unaviable
    bicycle.state = :assigned
    bicycle.save
  end

  def bike_aviable
    bicycle.state = :aviable
    bicycle.save
  end

  def validate_student
    errors.add(:bicycle, :invalid, message: "Student has one bike assigned") if student.lendings.count > 0
  end

end
