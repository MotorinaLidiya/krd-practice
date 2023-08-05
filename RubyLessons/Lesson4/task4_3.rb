def balance(file_path)
  File.exist?(file_path) ? File.read(file_path).to_f : START_BALANCE
end

def gets_with_output(output)
  puts output
  gets.chomp.to_f
end

def deposit_money(amount)
  return 'Сумма для начисления не корректна. Она должна быть положительным значением.' if amount <= 0

  @current_balance += amount
  'Средства успешно начислены!'
end

def withdraw_money(amount)
  if amount <= 0
    'Сумма для снятия не корректна. Она должна быть положительным значением.'
  elsif amount > @current_balance
    'Указанная сумма не может быть снята, на балансе недостаточно средств.'
  else
    @current_balance -= amount
    'Снятие средств прошло успешно!'
  end
end

def show_balance
  puts "Ваш текущий баланс: #{@current_balance}"
end

def save_balance_and_quit
  File.write('./data1/balance.txt', @current_balance)
  puts 'Баланс успешно сохранен!'
end

def main
  @current_balance = balance('./data1/balance.txt')
  show_balance

  loop do
    puts
    puts 'Выберите действие:'
    puts 'D - Внести деньги'
    puts 'W - Снять деньги'
    puts 'B - Показать баланс'
    puts 'Q - Выйти'

    user_input = gets.chomp.downcase

    case user_input
    when 'd'
      show_balance
      puts deposit_money(gets_with_output('Сколько положить на счет?'))
    when 'w'
      show_balance
      puts withdraw_money(gets_with_output('Введите сумму для вывода:'))
    when 'b'
      show_balance
    when 'q'
      save_balance_and_quit
      break
    else
      puts 'Такой команды нет, попробуйте еще раз.'
    end
  end
end

START_BALANCE = 100.0
main
