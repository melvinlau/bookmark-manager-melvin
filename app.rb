require 'sinatra/base'
require 'sinatra/flash'
require 'uri'
require './database_connection_setup'
require './lib/bookmark'
require './lib/comment'

class BookmarkManager < Sinatra::Base

  enable :sessions, :method_override
  register Sinatra::Flash

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
    bookmark = Bookmark.create(url: params[:url], title: params[:title])
    flash[:notice] = "You must submit a valid URL." unless bookmark
    redirect '/bookmarks'
  end

  delete '/bookmarks/:id/delete' do
    Bookmark.delete(id: params[:id])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/edit' do
    @bookmark = Bookmark.find(id: params['id'])
    erb(:'bookmarks/edit')
  end

  patch '/bookmarks/:id' do
    url = params[:url]
    title = params[:title]
    id = params[:id]
    Bookmark.update(id: id, url: url, title: title)
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/comments/new' do
    @bookmark_id = params['id']
    erb:'comments/new'
  end

  post '/bookmarks/:id/comments' do
    Comment.create(text: params[:comment], bookmark_id: params[:id])
    redirect '/bookmarks'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0

end
