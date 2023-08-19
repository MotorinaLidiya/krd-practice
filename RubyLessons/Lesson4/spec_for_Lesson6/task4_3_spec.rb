require 'rspec'
require 'tempfile'
require 'simplecov'

SimpleCov.start do
  add_filter '/spec/'
end

require_relative '../task4_3'

RSpec.describe 'BankingApplication' do
  let(:balance_file_path) { './data1/balance.txt' }

  before do
    allow_any_instance_of(Kernel).to receive(:puts)  # Suppress console outputs
    allow_any_instance_of(Kernel).to receive(:gets).and_return(*user_inputs)
  end

  after do
    File.delete(balance_file_path) if File.exist?(balance_file_path)
  end

  context 'balance' do
    it 'returns START_BALANCE if balance file does not exist' do
      expect(balance(balance_file_path)).to eq(START_BALANCE)
    end

    it 'returns the balance from file if it exists' do
      File.write(balance_file_path, '150.0')
      expect(balance(balance_file_path)).to eq(150.0)
    end
  end

  context 'deposit_money' do
    it 'deposits money and updates current balance' do
      expect(deposit_money(50.0)).to eq('Средства успешно начислены!')
      expect(@current_balance).to eq(START_BALANCE + 50.0)
    end

    it 'returns an error message for non-positive amount' do
      expect(deposit_money(-10.0)).to eq('Сумма для начисления не корректна. Она должна быть положительным значением.')
    end
  end

  context 'withdraw_money' do
    it 'withdraws money and updates current balance' do
      @current_balance = 150.0
      expect(withdraw_money(50.0)).to eq('Снятие средств прошло успешно!')
      expect(@current_balance).to eq(100.0)
    end

    it 'returns an error message for non-positive amount' do
      expect(withdraw_money(-10.0)).to eq('Сумма для снятия не корректна. Она должна быть положительным значением.')
    end

    it 'returns an error message for insufficient balance' do
      @current_balance = 50.0
      expect(withdraw_money(100.0)).to eq('Указанная сумма не может быть снята, на балансе недостаточно средств.')
    end
  end

  context 'main' do
    let(:user_inputs) { ['b', 'q'] }  # Simulate choosing "b" and then "q"

    it 'correctly handles user inputs' do
      allow(self).to receive(:balance).and_return(START_BALANCE)
      expect(self).to receive(:show_balance).twice
      expect(self).to receive(:save_balance_and_quit)

      main
    end
  end
end
