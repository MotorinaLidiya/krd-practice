require 'rspec'
require './task2'

RSpec.describe 'task2' do
  it 'Sum numbers' do
    expect(foobar(15, 21)).to eq(36)
  end

  it 'Should return second number' do
    expect(foobar(20, 15)).to eq(15)
  end

  it 'Should return second number' do
    expect(foobar(10, 20)).to eq(20)
  end
end
