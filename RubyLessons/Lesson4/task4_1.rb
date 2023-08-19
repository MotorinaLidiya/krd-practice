class MyFile
  def index
    @readed_file
  end

  def find(id)
    @readed_file[id - 1]
  end

  def where(pattern)
    @readed_file.select { |line| line[/#{pattern}/i] }
  end

  def update(id, text)
    @readed_file[id - 1] = text << $INPUT_RECORD_SEPARATOR
    File.open(@current_path, 'w') { |f| f.write(@readed_file.join) }
  end

  def delete(id)
    @readed_file.delete_at(id - 1)
    File.open(@current_path, 'w') { |f| f.write(@readed_file.join) }
  end

  def create(name)
    @readed_file << name
    File.open(@current_path, 'w') { |f| f.write(@readed_file.join) }
    # без переписывания файла, чисто добавить строку:
    # File.open(@current_path,"a") { |f| f.write(name << $/) }
  end

  def main(current_path)
    @current_path = current_path
    file = File.open(@current_path)
    @readed_file = file.readlines
    file.close
  end
end

# file = MyFile.new

# file.main('./data1/about_ruby.txt')
# puts file.index
# puts file.find(1)
# puts file.where('Ruby')
# puts file.update(10, 'Все о языке программирования Ruby')
# puts file.delete(11)
# puts file.create('Все о языке программирования Ruby')
