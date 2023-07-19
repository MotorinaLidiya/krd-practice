def greeting(first_name, middle_name, age)
	greeting_message = "Привет, #{first_name} #{middle_name}."
	age_message = age < 18 ? 'Тебе меньше 18 лет, но начать учиться программировать никогда не рано.' : 'Самое время заняться делом!'
	puts "#{greeting_message} #{age_message}"
end

greeting('Николай', 'Иванов', 20)
greeting('Василиса', 'Петрова', 17)