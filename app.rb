# блог
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

# обявление БД
set :database, "sqlite3:blogosorium.db"

# модель - пост
class Post < ActiveRecord::Base
end

# модель - коментарий
class Comment < ActiveRecord::Base
end

# главная страница
get '/' do
	erb :posts
end

# добавить пост
get '/new' do
	erb :new
end

# детальная информация о посте №:id
get '/post/:id' do
	@id=params[:id]
	erb :onepost
end

# обработчик формы создания поста
post '/new' do
  @name=params[:name]
  @post=params[:post]

  # получение сообщения об ошибке. если есть, то снова вводим,
  # если нет, то пост записывается в БД и идет перенаправление на главную страницу
  @error=get_error_message({:name=>"Enter your name. ", :post=>"Enter your post"})
  if @error==""
  	$db.execute("INSERT INTO posts (p_name, p_post) VALUES (?, ?)", [@name, @post])
  	redirect to ('/')
  else
  	erb :new
  end
end

# обработчик формы ввода комментария
post '/post/:id' do
	@id=params[:id]
	@name_c=params[:name_c]
	@comment=params[:comment]

  	# получение сообщения об ошибке. если нет, то комментарий записывается в БД и 
  	# в любом случае идет перенаправление на форму с детальной информацией о посте
  	@error=get_error_message({:name_c=>"Enter your name. ", :comment=>"Enter your comment"})
 	if @error==""
  		$db.execute("INSERT INTO comments (p_id, c_name, c_comment) VALUES (?, ?, ?)", [@id, @name_c, @comment])
  	end
  	erb :onepost
end

# возвращает сообщение о возможных ошибках. принмимает хеш с парой
# имя_параметра=>выводимое сообщение. если параметр пустой, формируется сообщение
def get_error_message(hh)
	err=""
	hh.each_key {|param| err+=hh[param] if params[param].strip==""}
	return err
end
