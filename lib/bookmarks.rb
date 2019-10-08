require 'pg'

class Bookmarks
  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      db = PG.connect(dbname: 'bookmark_manager_test')
    else
      db = PG.connect(dbname: 'bookmark_manager')
    end
      result = db.exec("SELECT * FROM bookmarks;")
      result.map { |bookmark| bookmark['url'] }
  end
end
