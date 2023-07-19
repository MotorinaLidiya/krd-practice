def foobar(first_number, second_number)
	first_number == 20 || second_number == 20 ? second_number : first_number + second_number
end

puts foobar(15, 21)
puts foobar(20, 22)
puts foobar(220, 20)