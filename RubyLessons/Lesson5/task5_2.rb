# Задание #2
# https://gist.github.com/AlxGolubev/b30af07fe3a0add200d1c693ac64133f
# Пользователь запускает программу и отвечает на вопрос, с каким ресурсом он хочет взаимодействовать
# - После чего он может передать тип запроса GET/POST/PUT/DELETE
# - GET index - должен возвращать все посты из памяти и их индекс в массиве (прим. 0. Hello World \n 1. Hello (again))
# - GET show - должен запрашивать идентификатор поста и показывать пост по переданному идентификатору (как в index только 1 пост)
# - POST create - должен запрашивать текст поста, добавлять его в массив постов и возвращать в ответ идентификатор поста и сам пост
# - PUT update - должен запрашивать идентификатор поста, потом новый текст поста и заменить его. В результате выводить пост (как в экшене index)
# - DELETE destroy - должен запрашивать идентификатор поста, затем удалять его из массива постов
# Нужно реализовать логику для PostsController
# В отчете по заданию расписать, понимание работы класса Router, причины, по которым используется extend для модуля Resource
# В случае неправильного ввода (команды), ваша программа должна выдать соответствующее сообщение об ошибке, которое говорит клиенту, как ее исправить. Нельзя просто выводить "Error!" - это не поможет.

module Resource
  def connection(routes)
    if routes.nil?
      puts "No route matches for #{self}"
      return
    end

    loop do
      print 'Choose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: '
      verb = gets.chomp
      break if verb == 'q'

      action = nil

      if verb == 'GET'
        print 'Choose action (index/show) / q to exit: '
        action = gets.chomp
        break if action == 'q'
      end

      action.nil? ? routes[verb].call : routes[verb][action].call
    end
  end
end

class PostsController
  extend Resource

  def initialize
    @posts = []
  end

  def index
    # GET index - должен возвращать все посты из памяти и их индекс в массиве (прим. 0. Hello World \n 1. Hello (again))
    @posts.each_with_index do |post, index|
      puts "Пост #{index}: #{post}"
    end
  end

  def show
    # GET show - должен запрашивать идентификатор поста и показывать пост по переданному идентификатору (как в index только 1 пост)
    gets_index_with_output('Введите идентификатор поста:')

    if @post
      puts "Пост #{@post_index}: #{@post}"
    else
      puts "Пост с идентификатором #{@post_index} не найден."
    end
  end

  def create
    # POST create - должен запрашивать текст поста, добавлять его в массив постов и возвращать в ответ идентификатор поста и сам пост
    post_message = gets_with_output('Введите текст поста:')
    @posts << post_message
    post_id = @posts.index(post_message)
    puts "Добавлен пост #{post_id}: #{post_message}"
  end

  def update
    # PUT update - должен запрашивать идентификатор поста, потом новый текст поста и заменить его. В результате выводить пост (как в экшене index)
    gets_index_with_output('Введите идентификатор поста:')

    if @post
      post_message = gets_with_output('Введите новый текст поста:')
      @posts[@post_index] = post_message
      puts "Пост #{@post_index}: #{post_message}"
    else
      puts "Пост с идентификатором #{@post_index} не найден."
    end
  end

  def destroy
    # DELETE destroy - должен запрашивать идентификатор поста, затем удалять его из массива постов
    gets_index_with_output('Введите идентификатор поста:')
    
    if @post
      @posts.delete_at(@post_index)
    else
      puts "Пост с идентификатором #{@post_index} не найден."
    end
  end

  private

  def gets_with_output(output)
    puts output
    gets.chomp.to_s
  end

  def gets_index_with_output(output)
    puts output
    @post_index = gets.chomp.to_i
    @post = @posts[@post_index]
  end
end

class Router
  def initialize
    @routes = {}
  end

  def init
    resources(PostsController, 'posts')

    loop do
      print 'Choose resource you want to interact (1 - Posts, 2 - Comments, q - Exit): '
      choice = gets.chomp

      PostsController.connection(@routes['posts']) if choice == '1'
      break if choice == 'q'
    end

    puts 'Good bye!'
  end

  def resources(klass, keyword)
    controller = klass.new
    @routes[keyword] = {
      'GET' => {
        'index' => controller.method(:index),
        'show' => controller.method(:show)
      },
      'POST' => controller.method(:create),
      'PUT' => controller.method(:update),
      'DELETE' => controller.method(:destroy)
    }
  end
end

router = Router.new

router.init
