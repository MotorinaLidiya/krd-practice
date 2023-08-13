class CashMachine
  START_BALANCE = 100.0

  def initialize(file_path)
    @file_path = file_path
    @current_balance = balance
  end

  def deposit_money(amount)
    return 'Сумма для начисления не корректна. Она должна быть положительным значением.' if amount <= 0

    @current_balance += amount
    save_balance
    'Средства успешно начислены!'
  end

  def withdraw_money(amount)
    if amount <= 0
      'Сумма для снятия не корректна. Она должна быть положительным значением.'
    elsif amount > @current_balance
      'Указанная сумма не может быть снята, на балансе недостаточно средств.'
    else
      @current_balance -= amount
      save_balance
      'Снятие средств прошло успешно!'
    end
  end

  def show_balance
    @current_balance
  end

  private

  def balance
    File.exist?(@file_path) ? File.read(@file_path).to_f : START_BALANCE
  end

  def save_balance
    File.write('./balance.txt', @current_balance)
  end
end
