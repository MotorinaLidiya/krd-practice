require 'rspec'
require 'tempfile'
require 'simplecov'

SimpleCov.start do
  add_filter '/spec/'
end

require_relative '../task4_1'

RSpec.describe MyFile do
  let(:temp_file) do
    file = Tempfile.new("test_file")
    file.write("Line 1\nLine 2\nLine 3\nLine 4\n")
    file.rewind
    file
  end

  let(:my_file) { MyFile.new }

  before do
    my_file.main(temp_file.path)
  end

  after do
    temp_file.close
    temp_file.unlink
  end

  describe '#index' do
    it 'returns the entire content of the file as an array' do
      expect(my_file.index).to eq(["Line 1\n", "Line 2\n", "Line 3\n", "Line 4\n"])
    end
  end

  describe '#find' do
    it 'returns the line at the specified index' do
      expect(my_file.find(2)).to eq("Line 2\n")
    end
  end

  describe '#where' do
    it 'returns an array of lines matching the pattern' do
      expect(my_file.where('Line')).to eq(["Line 1\n", "Line 2\n", "Line 3\n", "Line 4\n"])
    end
  end

  describe '#update' do
    it 'updates the line at the specified index' do
      my_file.update(3, 'Updated Line')
      expect(my_file.find(3)).to eq("Updated Line\n")
    end
  end

  describe '#delete' do
    it 'deletes the line at the specified index' do
      my_file.delete(2)
      expect(my_file.index).to eq(["Line 1\n", "Line 3\n", "Line 4\n"])
    end
  end

  describe '#create' do
    it 'adds a new line to the file' do
      my_file.create('New Line')
      expect(my_file.index).to eq(["Line 1\n", "Line 2\n", "Line 3\n", "Line 4\n", "New Line"])
    end
  end
end
