require 'set'

def people_form_file
  File.readlines('./data1/name_age.txt', chomp: true).each_with_object({}) do |line, hash|
    name, last_name, age = line.split
    hash[age.to_i] ||= []
    hash[age.to_i] << "#{name} #{last_name}"
  end
end

def prepared_data
  {
    result: File.new('./data1/results.txt', 'w'),
    people_form_file: people_form_file,
    added_ages: Set.new
  }
end

def add_people(age)
  return 'Данный возраст не указан в списке' if @data[:people_form_file][age].nil?
  return 'Люди этого возраста уже добавлены в список' if @data[:added_ages].include?(age)

  add_people_to_file(age, @data[:people_form_file][age])
end

def add_people_to_file(age, full_name)
  @data[:added_ages].add(age)
  @data[:result].puts(full_name)
  'Имена успешно добавлены в список'
end

@data = prepared_data

until @data[:people_form_file].size == @data[:added_ages].size
  puts "Введите нужный возраст (или -1 для выхода):\n"
  age = gets.chomp.to_i
  break if age == -1

  puts add_people(age)
end

@data[:result].close
puts File.readlines('./data1/results.txt', chomp: true)
