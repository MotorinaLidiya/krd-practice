require 'sinatra'
require 'json'
require_relative './CashMachine'

before do
  content_type :json
end

$cash_machine = CashMachine.new('./balance.txt')

helpers do
  def result(message)
    { result: message }.to_json
  end

  def balance(value)
    { balance: value }.to_json
  end
end

get '/balance' do
  balance($cash_machine.show_balance)
end

get '/deposit' do
  value = params['value'].to_f
  result($cash_machine.deposit_money(value))
end

get '/withdraw' do
  value = params['value'].to_f 
  result($cash_machine.withdraw_money(value))
end
