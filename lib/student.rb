class Student
  attr_accessor :name, :grade, :save
  attr_reader :id

  def initialize(id=1, name, grade)
    @id = id
    @name = name
    @grade = grade
  end
  
  def self.create_table
    sql = <<-SQL
    CREATE TABLE students ( 
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name text,
      grade text
    ) 
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
    DROP TABLE students
    SQL

    DB[:conn].execute(sql)
  end

  def self.create(options={})
    @name = options[:name]
    @grade = options[:grade]
    student = Student.new(@name, @grade)
    student.save
    student
  end

  def save
    sql = <<-SQL
    INSERT INTO students VALUES (?, ?, ?)
    SQL

    DB[:conn].execute(sql, id, name, grade)

  end

end
