module Partials
  def self.intro
    puts 'Welcome to the School library App!'.blue
  end

  def self.menu
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

  def self.read_name
    print 'Name: '
    name = gets.chomp
    name.empty? ? read_name : name
  end

  def self.read_age
    print 'Age: '
    age = gets.chomp.to_i
    (1..1000).include?(age) ? age : read_age
  end

  def self.read_permission
    print 'Has parent permission? [Y/N]: '
    permission = gets.chomp
    %w[Y N].include?(permission.capitalize) ? permission.capitalize : read_permission
  end

  def self.read_specialization
    print 'Specialization: '
    specialization = gets.chomp
    specialization.empty? ? read_specialization : specialization
    print "\e[2J\e[f"
  end
end
