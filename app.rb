require 'colorize'
require_relative './person'
require_relative './classroom'
require_relative './student'
require_relative './book'
require_relative './rental'
require_relative './teacher'

class App
  attr_accessor :user_input

  def initialize
    menu
    @user_input = gets.chomp
    @default_classroom = Classroom.new('default-classroom')
    @people = []
    @books = []
    @rentals = []
  end

  def user_input_valid?(user_input, arr)
    arr.include?(user_input)
  end

  def student_info
    age = read_age
    name = read_name
    has_parent_permission = read_permission == 'Y'
    [age, name, has_parent_permission]
  end

  def teacher_info
    age = read_age
    name = read_name
    specialization = read_specialization
    [age, name, specialization]
  end

  def create_person
    print "\nDo you want to create a student (1) or a teacher (2)? [Input the number]: "
    @user_input = gets.chomp
    create_person unless user_input_valid?(user_input, %w[1 2])
    case @user_input
    when '1'
      age, name, has_parent_permission = student_info
      person = Student.new(age, @default_classroom, name, parent_permission: has_parent_permission)
    when '2'
      age, name, specialization = teacher_info
      person = Teacher.new(age, specialization, name)
   else
        puts 'Invalid input'
        create_person
    end

    @people << person
    puts 'Person created successfully'
  end

  def read_title
    print 'Title: '
    title = gets.chomp
    title.empty? ? read_title : title
  end

  def read_author
    print 'Author: '
    author = gets.chomp
    author.empty? ? read_author : author
  end

  def create_book
    title = read_title
    author = read_author
    book = Book.new(title, author)
    @books << book
    puts 'Book created successfully'
  end

  def list_all_books
    @books.each_with_index { |book, index| puts "#{index}) Title: \"#{book.title}\", Author: \"#{book.author}\"" }
    puts "Enter any key to continue to Menu:"
    anykey = gets.chomp

  end

  def list_all_people
    @people.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    puts "Enter any key to continue to Menu:"
    anykey = gets.chomp
  end

  def read_desired_book
    puts "\nSelect a book from the following list by Number"
    list_all_books
    desired_book_index = gets.chomp
    (0...@books.length).include?(desired_book_index.to_i) ? desired_book_index.to_i : read_desired_book
  end

  def read_desired_person
    puts "\nSelect a person from the following list by Number"
    list_all_people
    desired_person_index = gets.chomp
    (0...@people.length).include?(desired_person_index.to_i) ? desired_person_index.to_i : read_desired_person
  end

  def read_desired_date
    print "\nDate: "
    gets.chomp
  end

  def create_rental
    return print '(Empty) Please add a book first' if @books.empty?
    return print '(Empty) Please add a person first' if @people.empty?

    book = @books[read_desired_book]
    person = @people[read_desired_person]
    date = read_desired_date

    rental = Rental.new(date, person, book)

    @rentals << rental
    puts 'Rental created successfully'
  end

  def create_for_user(user_input)
    case user_input
    when '3'
      create_person
    when '4'
      create_book
    when '5'
      create_rental
    end
  end

  def list_all_rentals_for_id
    return puts 'Please add a rental first' if @rentals.empty?

    puts "\nSelect a person from the following list by number"
    @people.each do |person|
      puts "ID: #{person.id}, [#{person.class}] Name: #{person.name}, Age: #{person.age}"
    end
    person_id = gets.chomp.to_i
    rental_list = @rentals.select { |rental| rental.person.id == person_id }
    if rental_list.empty?
      puts 'No rentals found for this person.'
    else
      rental_list.each do |rental|
        puts "Date: #{rental.date}, Book: \"#{rental.book.title}\" by  #{rental.book.author}"
      end
    end
  end

  def display_for_user(user_input)
    case user_input
    when '1'
      list_all_books
    when '2'
      list_all_people
    when '6'
      list_all_rentals_for_id
    end
  end

  def run
    loop do
      case user_input
      when '1', '2', '6'
        display_for_user(user_input)
      when '3', '4', '5'
        create_for_user(user_input)
      when '7'
        puts 'Thank you for using this app!'
        exit(true)
      else
        puts "\nInvalid input \"#{user_input}\"!"
        puts 'Error, please try with one of these options:'
        menu
        @user_input = gets.chomp
        run
      end
      menu
      @user_input = gets.chomp
    end
  end
  #PARTIALS --------------------------------------------------------------------------
  def intro
    puts 'Welcome to the School library App!'.blue
  end

  def menu
    intro
    puts '
            Please choose an option by entering a number:
            1, List all books
            2, List all people
            3, Create a person
            4, Create a book
            5, Create a rental
            6, List all rentals for a given person id
            7, Exit'
    print 'option: '
  end

  def read_name
    print 'Name: '
    name = gets.chomp
    name.empty? ? read_name : name
  end

  def read_age
    print 'Age: '
    age = gets.chomp.to_i
    (1..1000).include?(age) ? age : read_age
  end

  def read_permission
    print 'Has parent permission? [Y/N]: '
    permission = gets.chomp
    %w[Y N].include?(permission.capitalize) ? permission.capitalize : read_permission
  end

  def read_specialization
    print 'Specialization: '
    specialization = gets.chomp
    specialization.empty? ? read_specialization : specialization
    print "\e[2J\e[f"
  end

  #PARTIALS END   --------------------------------------------------------------------
end

def main
  app = App.new
  app.run
end
main