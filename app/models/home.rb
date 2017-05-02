class Home < ApplicationRecord
  validates :address, :city, length: { in: 5..60 }
  validates :state, length: { is: 2 }
  validates :zip, length: { is: 5 }, numericality: true
  validates :number_bedrooms, :number_bathrooms, length: { in: 1..2 }, numericality: true
  validates :price, length: { in: 4..10 }, numericality: true
  validates :description, length: { in: 0..5000 }
  validates :roof, :city, length: { in: 2..30 }
  validates :lot_size, length: { in: 2..10 }, numericality: true
  validates :hoa, inclusion: { in: [true, false] }
  validates :number_of_floors, length: { is: 1 }, numericality: true
  validates :year_built, length: { is: 4 }, numericality: true

  is_impressionable

  include ImageUploader[:image]

  belongs_to :created_by, class_name: "User"

  def can_this_user_edit?(user)
    created_by == user
  end

  def can_this_user_destroy?(user)
    created_by == user
  end

  def self.search(search)
    where("address LIKE ? or city LIKE ? or state LIKE ? or zip = ?", "%#{search}%", "%#{search}%", "%#{search}%", search.to_i)
  end

  def square_meters
    sq_ft * 0.0929
  end
end
