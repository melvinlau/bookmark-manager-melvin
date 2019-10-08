require 'bookmark'
require_relative 'database_helpers'

describe Bookmark do

  before(:each) do
    connection = PG.connect(dbname: 'bookmark_manager_test')
  end

  describe ".all" do
    it 'returns a list of bookmarks' do
      bookmark = Bookmark.create(url: 'https://www.makers.tech', title: 'Makers')
      bookmarks = Bookmark.all

      expect(bookmarks.length).to eq 1
      expect(bookmarks.first).to be_a Bookmark
      expect(bookmarks.first.id).to eq bookmark.id
      expect(bookmarks.first.title).to eq 'Makers'
      expect(bookmarks.first.url).to eq 'https://www.makers.tech'
    end
  end

  describe ".create" do
    it "saves a new entry to the bookmarks table" do
      bookmark = Bookmark.create(url: "https://www.makers.tech", title: "Makers")
      persisted_data = persisted_data(id: bookmark.id)

      expect(bookmark).to be_a Bookmark
      expect(bookmark.id).to eq persisted_data['id']
      expect(bookmark.title).to eq 'Makers'
      expect(bookmark.url).to eq 'https://www.makers.tech'
    end
  end

  describe ".delete" do
    it "deletes an entry in the bookmarks table" do
      bookmark = Bookmark.create(url: 'https://www.google.com', title: 'Google')
      Bookmark.delete(id: bookmark.id)

      expect(Bookmark.all.length).to eq 0
    end
  end

end
