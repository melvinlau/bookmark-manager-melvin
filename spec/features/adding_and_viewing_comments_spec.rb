feature "Add and then view comments" do
  scenario "A comment is added to a bookmark" do
    bookmark = Bookmark.create(url: 'http://www.google.com', title: 'Google')
    visit '/bookmarks'
    first('.bookmark').click_button "Add Comment"
    expect(current_path).to eq "/bookmarks/#{bookmark.id}/comments/new"
    fill_in 'comment', with: 'This is a comment.'
    click_button 'Submit'
    expect(current_path).to eq '/bookmarks'
    expect(first('.bookmark')).to have_content 'This is a comment.'
  end
end
