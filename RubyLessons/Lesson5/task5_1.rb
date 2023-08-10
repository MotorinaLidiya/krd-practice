# Переписать банкомат из ЛЗ #3 на работу с классами
# Класс должен называться - CashMachine.
# Программа должна запускаться с помощью метода класса  init, создавать экземпляр класса и взаимодействовать с пользователем согласно условиям задачи
require_relative 'CashMachine'

cash_machine = CashMachine.new('./data2/balance.txt')
cash_machine.init
