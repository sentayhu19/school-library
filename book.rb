require_relative './rental'
class Book
  attr_accessor :title, :author
  attr_reader :rentals

  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
  end

  def add_rental(person, date, book)
    @rental = Rental.new(date, person, book)
    @rental.student = person
    @rental.book = book
  end
end
