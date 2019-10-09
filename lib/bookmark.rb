# require 'database_connection'
# database connection already required in app.rb

class Bookmark

  attr_reader :id, :title, :url

  def self.all
    result = DatabaseConnection.query("SELECT * FROM bookmarks;")
    result.map do |bookmark|
      Bookmark.new(id: bookmark['id'], url: bookmark['url'], title: bookmark['title'])
    end
  end

  def self.create(url:, title:)
    sql = "INSERT INTO bookmarks (url, title) VALUES('#{url}', '#{title}') RETURNING id, url, title;"
    result = DatabaseConnection.query(sql)
    Bookmark.new(id: result[0]['id'], url: result[0]['url'], title: result[0]['title'])
  end

  def self.delete(id:)
    DatabaseConnection.query("DELETE FROM bookmarks WHERE id = #{id};")
  end

  def self.update(id:, url:, title:)
    sql = "UPDATE bookmarks SET url='#{url}', title='#{title}' WHERE id='#{id}' RETURNING id, url, title"
    result = DatabaseConnection.query(sql)
    Bookmark.new(id: result[0]['id'], url: result[0]['url'], title: result[0]['title'])
  end

  def self.find(id:)
    result = DatabaseConnection.query("SELECT * FROM bookmarks WHERE id = #{id}")
    Bookmark.new(id: result[0]['id'], url: result[0]['url'], title: result[0]['title'])
  end

  def initialize(id:, title:, url:)
    @id = id
    @title = title
    @url = url
  end

end
