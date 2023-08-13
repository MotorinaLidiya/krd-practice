require 'rspec'
require 'simplecov'

SimpleCov.start do
  add_filter '/spec/'
end

require './task1'

RSpec.describe 'task1' do
  it 'When age more than 18' do
    expect(greeting('Вася', 'Пупкин', 20)).to eq 'Привет, Вася Пупкин. Самое время заняться делом!'
  end

  it 'When age less than 18' do
    expect(greeting('Вася', 'Пупкин', 10))
      .to eq 'Привет, Вася Пупкин. Тебе меньше 18 лет, но начать учиться программировать никогда не рано.'
  end
end
