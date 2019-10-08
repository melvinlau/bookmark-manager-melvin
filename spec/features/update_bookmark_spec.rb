feature "Update bookmark" do
  scenario "User can update a bookmark" do
    bookmark = Bookmark.create(url: 'https://www.makers.tech', title: 'Makers')
    visit '/bookmarks'
    expect(page).to have_link('Makers', href: 'https://www.makers.tech')

    first('.bookmark').click_button('Edit')
    expect(current_path).to eq "/bookmarks/#{bookmark.id}/edit"

    fill_in 'url', with: 'https://www.snakers.tech'
    fill_in 'title', with: 'Snakers Academy'
    click_button 'Submit'

    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link('Makers', href: 'https://www.makers.tech')
    expect(page).to have_link('Snakers', href: 'https://www.snakers.tech')
  end
end
