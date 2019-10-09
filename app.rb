require 'sinatra/base'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base

  enable :sessions, :method_override

  get '/' do
    "Hello world"
  end

  get '/bookmarks' do
    @list = Bookmark.all
    erb :'bookmarks/index'
  end

  get '/bookmarks/new' do
    erb :'bookmarks/new'
  end

  post '/bookmarks/save' do
    Bookmark.create(url: params[:url], title: params[:title])
    redirect '/bookmarks'
  end

  delete '/bookmarks/:id' do
    Bookmark.delete(id: params[:id])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/edit' do
    @bookmark_id = params['id']
    erb(:'bookmarks/edit')
  end

  patch '/bookmarks/:id' do
    p params
    url = params[:url]
    title = params[:title]
    id = params[:id]
    connection = PG.connect(dbname: 'bookmark_manager_test')
    connection.exec("UPDATE bookmarks SET url='#{url}', title='#{title}' WHERE id='#{id}'")
    redirect '/bookmarks'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0

end
