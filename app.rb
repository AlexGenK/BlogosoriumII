# блог
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

# обявление БД
set :database, "sqlite3:blogosorium.db"

# модель - пост
class Post < ActiveRecord::Base
	# один пост - много комментов
	has_many :comments
end

# модель - коментарий
class Comment < ActiveRecord::Base
	# коммент привязан к одному посту
	belongs_to :post
end

# главная страница
get '/' do

	# выборка простов в порядке обратном порядку создания
	@p=Post.order(:updated_at).reverse_order
	erb :posts
end

# добавить пост
get '/new' do
	erb :new
end

# детальная информация о посте №:id
get '/post/:id' do
	@p=Post.find(params[:id])
	erb :onepost
end

# обработчик формы создания поста
post '/new' do

	p=Post.new params[:post]

	# получение сообщения об ошибке. если есть, то снова вводим,
	# если нет, то пост записывается в БД и идет перенаправление на главную страницу
	if p.save
		redirect to ('/')
	else
		erb :new
	end
end

# обработчик формы ввода комментария
post '/post/:id' do

	# создаем коммент, связанный с постом по его айди
	c=Post.find(params[:id]).comments.create(params[:comment])

  	# получение сообщения об ошибке. если нет, то комментарий записывается в БД и 
  	# в любом случае идет перенаправление на форму с детальной информацией о посте
 	if c.save
  	end
  	redirect to ("/post/#{params[:id]}")
end