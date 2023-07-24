require 'rspec'
require './task3_1'

RSpec.describe 'task3_1' do
  it 'When ends on "cs" should return 2 multiplied 2 equal to the number of letters in the word times' do
    expect(word_processing('docs')).to eq(16)
  end

  it 'When doesnt ends on "cs" should return reverse meaning' do
    expect(word_processing('excel')).to eq('lecxe')
  end
end
