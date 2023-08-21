require 'rspec'
require 'tempfile'
require 'simplecov'

SimpleCov.start do
  add_filter '/spec/'
end

require_relative '../task4_2'

RSpec.describe do
  before do
    @data = {
      result: Tempfile.new('results.txt'),
      people_form_file: {
        25 => ['John Doe', 'Jane Smith'],
        30 => ['Alice Johnson', 'Bob Brown']
      },
      added_ages: Set.new
    }
  end

  after do
    @data[:result].close
    @data[:result].unlink
  end

  describe '#add_people' do
    context 'when age is not in the list' do
      it 'returns an error message' do
        expect(add_people(18)).to eq('Данный возраст не указан в списке')
      end
    end

    context 'when people of the same age are already added' do
      it 'returns an error message' do
        @data[:added_ages].add(25)
        expect(add_people(25)).to eq('Люди этого возраста уже добавлены в список')
      end
    end

    context 'when adding people of a valid age' do
      it 'adds people to the result file and returns a success message' do
        expect(add_people(25)).to eq('Имена успешно добавлены в список')
        expect(@data[:result].readlines(chomp: true)).to eq(['John Doe', 'Jane Smith'])
      end
    end
  end
end
