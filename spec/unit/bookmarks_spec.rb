require 'bookmarks'

describe Bookmarks do

  it 'returns a list of bookmarks' do

    connection = PG.connect(dbname: 'bookmark_manager_test')

    # Add the test data
    connection.exec("INSERT INTO bookmarks (url) VALUES('http://www.google.com');")

    expect(Bookmarks.all).to include "http://www.google.com"
  end

end
