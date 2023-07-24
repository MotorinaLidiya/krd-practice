require 'rspec'
require './task3_2'

RSpec.describe 'task3_2' do
  it 'puts hash with name and color' do
    allow_any_instance_of(Kernel).to receive(:gets).and_return('Пикачу', 'Желтый')

    expect(pokemon_number).to eq({ name: 'Пикачу', color: 'Желтый' })
  end

  it 'puts hashes with name and color quantity times' do
    allow_any_instance_of(Kernel).to receive(:gets).and_return('Пикачу', 'Желтый', 'Сильвеон', 'Голубой')

    expect(pokemons(2)).to eq([ { name: 'Пикачу', color: 'Желтый' }, { name: 'Сильвеон', color: 'Голубой' } ])
  end
end
