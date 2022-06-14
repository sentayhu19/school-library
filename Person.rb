class Person
  attr_accessor :name, :age, parent_permission
  def initialize(name="Unknown",age,parent_permission=true)
          @name = name
          @parent_permission = parent_permission;
          @age = age;
          @id = Random.rand(1...5000)
   end
   # getter methods
   def getName
    @name
  end
  def getId
    @id
  end
  def getAge
    @age
  end
  #setter methods
  def setname=(name) 
    @name = name
  end
  def setAge=(age)
    @age = age
  end

  def is_of_age?
    @age>=18
  end
  private :is_of_age
def can_use_services?
  if(@parent_permission)
    return true
  return false;
end
end