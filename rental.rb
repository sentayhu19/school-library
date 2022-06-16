require_relative './book'
class Rental
  attr_accessor :date
  attr_reader :book, :person

  def initialize(date, person, book)
    @date = date
    @person = person
    @person.rental = self
    @book = book
    @book.rental = self
  end

  def person=(person)
    @person = person
    person.rental = self
  end

  def book=(book)
    @book = book
    book.rental = self
  end
end
