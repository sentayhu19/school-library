require_relative './rental'
class Book
  attr_accessor :title, :author, :rental

  def initialize(title, author)
    @title = title
    @author = author
  end

  def add_rental(person, date)
    @rental = Rental.new(date)
    @rental.student = person
  end
end
