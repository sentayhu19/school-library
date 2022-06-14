class Person
  attr_accessor :name, :age, parent_permission

  def initialize(age, name = 'Unknown', parent_permission: true)
    @name = name
    @parent_permission = parent_permission
    @age = age
    @id = Random.rand(1...5000)
  end
  # getter methods

  def name_geter
    @name
  end

  def id_getter
    @id
  end

  def age_getter
    @age
  end
  # setter methods

  def name_setter(name)
    @name = name
  end

  def age_setter(age)
    @age = age
  end

  def of_age?
    @age >= 18
  end
  private :is_of_age
  def can_use_services?
    of_age? || @parent_permission
  end
end
