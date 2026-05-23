class SchoolClass < ApplicationRecord
  has_many :students, foreign_key: "class_id", dependent: :destroy

  validates :number, :letter, presence: true
end
