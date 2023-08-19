require 'rspec'
require 'tempfile'
require 'simplecov'

SimpleCov.start do
  add_filter '/spec/'
end

require_relative '../task4_2'

RSpec.describe 'PeopleManager' do
  let(:data) { prepared_data }
  let(:people_manager) { PeopleManager.new(data) }

  before do
    allow(File).to receive(:readlines).and_call_original
    allow(File).to receive(:readlines).with('./data1/name_age.txt', chomp: true).and_return([
      "John Doe 30",
      "Jane Smith 25",
      "Alice Johnson 30"
    ])
  end

  context 'add_people_to_file' do
    it 'adds people to the result file' do
      expect(data[:added_ages]).to receive(:add).with(30)
      expect(data[:result]).to receive(:puts).with(["John Doe", "Alice Johnson"])
      expect(people_manager.add_people_to_file(30, ["John Doe", "Alice Johnson"])).to eq('Имена успешно добавлены в список')
    end
  end

  context 'add_people' do
    it 'adds people of a specific age to the result file' do
      expect(data[:added_ages]).to receive(:include?).with(25).and_return(false)
      expect(people_manager.add_people(25)).to eq('Имена успешно добавлены в список')
    end

    it 'returns a message if people of the given age are already added' do
      expect(data[:added_ages]).to receive(:include?).with(30).and_return(true)
      expect(people_manager.add_people(30)).to eq('Люди этого возраста уже добавлены в список')
    end

    it 'returns a message if age is not found in people_form_file' do
      expect(data[:people_form_file]).to receive(:[]).with(40).and_return(nil)
      expect(people_manager.add_people(40)).to eq('Данный возраст не указан в списке')
    end
  end

  context 'main loop' do
    it 'adds people to the result file until all ages are processed' do
      allow(data[:result]).to receive(:close)
      allow(data[:result]).to receive(:puts)

      allow(people_manager).to receive(:gets).and_return("30\n", "25\n", "-1\n")

      expect { people_manager.run }.to output(
        "Введите нужный возраст (или -1 для выхода):\n" \
        "Имена успешно добавлены в список\n" \
        "Введите нужный возраст (или -1 для выхода):\n" \
        "Имена успешно добавлены в список\n"
      ).to_stdout
    end
  end
end
