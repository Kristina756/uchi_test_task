require 'rails_helper'

RSpec.describe Student, type: :model do
  it "is not valid without a first_name" do
    student = Student.new(first_name: nil)
    expect(student).to_not be_valid
  end

  it "is valid with all required fields" do
    school_class = SchoolClass.create!(number: 1, letter: 'А', students_count: 0)

    student = Student.new(
      first_name: "Ivan",
      last_name: "Ivanov",
      surname: "Ivanovich",
      school_id: 1,
      school_class: school_class
    )

    expect(student).to be_valid
  end
end
