require_relative './nameable'
require_relative './capitalize_decorator'
require_relative './trimmer_decorator'
class Person < Nameable
  attr_accessor :name, :age, :id

  def initialize(age, name = 'Unknown', parent_permission: true)
    @name = name
    @parent_permission = parent_permission
    @age = age
    @id = Random.rand(1...5000)
  end

  def of_age?
    @age >= 18
  end
  private :of_age?
  def can_use_services?
    of_age? || @parent_permission
  end
  public :can_use_services?
  def correct_name
    @name
  end
end
#Check decorate for person
person = Person.new(22, 'maximilianus')
  person.correct_name
  capitalizedPerson = CapitalizeDecorator.new(person)
  puts capitalizedPerson.correct_name
  capitalizedTrimmedPerson = TrimmerDecorator.new(capitalizedPerson)
  puts capitalizedTrimmedPerson.correct_name
