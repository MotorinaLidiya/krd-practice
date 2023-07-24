# Написать скрипт, который будет принимать слово, если слово заканчивается на “CS” (в любом регистре) - выводит на экран
# цифру 2 в степени (длины введенного слова), если не заканчивается - выводит слово задом наперед

def word_processing(word)
  return 2**word.length if word.downcase.end_with?('cs')

  word.reverse
end

word = gets.chomp
puts word_processing(word)
