# #Написать скрипт, который будет выводить массив покемонов
# - Спросит сколько добавить покемонов
# - Указанное на предыдущем этапе число раз спросит имя и цвет каждого покемона
# - Выведет в консоль массив содержащий хеши покемонов в формате
# - [{ name: ‘Pikachu’, color: ‘Yellow’ }, … n times{}]
# * Код должен быть организован в методы

def get_with_output(output)
  puts output
  gets.chomp
end

def pokemon_number
  pokemon_name = get_with_output('Дайте покемону имя:')
  pokemon_color = get_with_output('Укажите цвет этого покемона:')
  { name: pokemon_name, color: pokemon_color }
end

def pokemons(quantity)
  (1..quantity).map { pokemon_number }
end

quantity = get_with_output('Сколько добавить покемонов?').to_i
puts pokemons(quantity)
