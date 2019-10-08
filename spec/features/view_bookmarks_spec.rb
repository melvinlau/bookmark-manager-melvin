feature 'View bookmarks' do
  scenario 'can view a list of bookmarks' do
    
    connection = PG.connect(dbname: 'bookmark_manager_test')

    # Add the test data
    connection.exec("INSERT INTO bookmarks VALUES(1, 'http://www.google.com');")

    visit('/bookmarks')
    expect(page).to have_content 'Bookmarks'
    expect(page).to have_content 'http://www.google.com'
  end
end
