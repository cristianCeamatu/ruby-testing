class Student
  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_then?(other_student)
    @grade > other_student.grade
  end

  protected

  def grade
    grade
  end
end

joe = Student.new('Joe', 9)
bob = Student.new('Bob', 7)

p 'Well done!' if joe.better_grade_then?(bob)
