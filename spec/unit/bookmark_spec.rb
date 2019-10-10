require 'bookmark'
require_relative './database_helpers'

describe Bookmark do

  let(:comment_class) { double(:comment_class) }

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
      persisted_data = persisted_data(id: bookmark.id, table: 'bookmarks')

      expect(bookmark).to be_a Bookmark
      expect(bookmark.id).to eq persisted_data.first['id']
      expect(bookmark.title).to eq 'Makers'
      expect(bookmark.url).to eq 'https://www.makers.tech'
    end

    it "does not create a bookmark if the given URL is invalid" do
      Bookmark.create(url: 'not a URL', title: 'nada con nada')
      expect(Bookmark.all).not_to include 'nada con nada'
    end
  end

  describe ".delete" do
    it "deletes an entry in the bookmarks table" do
      bookmark = Bookmark.create(url: 'https://www.google.com', title: 'Google')
      Bookmark.delete(id: bookmark.id)
      expect(Bookmark.all.length).to eq 0
    end
  end

  describe ".update" do
    it "updates a bookmark with the given data" do
      bookmark = Bookmark.create(url: 'https://www.makers.tech', title: 'Makers')
      updated_bookmark = Bookmark.update(id: bookmark.id, url: 'https://www.snakers.tech', title: 'Snakers')
      expect(updated_bookmark).to be_a Bookmark
      expect(updated_bookmark.id).to eq bookmark.id # IDs must be the same!
      expect(updated_bookmark.url).to eq 'https://www.snakers.tech'
      expect(updated_bookmark.title).to eq 'Snakers'
    end
  end

  describe ".find" do
    it "returns the requested bookmark object" do
      bookmark = Bookmark.create(url: 'https://www.makers.tech', title: 'Makers')
      result = Bookmark.find(id: bookmark.id)
      expect(result).to be_a Bookmark
      expect(result.id).to eq bookmark.id
      expect(result.url).to eq 'https://www.makers.tech'
      expect(result.title).to eq 'Makers'
    end
  end

  describe "#comments" do

    # it 'returns a list of comments associated with the bookmark' do
    #   bookmark = Bookmark.create(url: 'https://www.makers.tech', title: 'Makers')
    #   sql = "INSERT INTO comments (id, text, bookmark_id) VALUES(1, 'Test comment', '#{bookmark.id}');"
    #   DatabaseConnection.query(sql)
    #   comment = bookmark.comments.first
    #   expect(comment['text']).to eq 'Test comment'
    # end

    it 'calls .where on the Comment class' do
      bookmark = Bookmark.create(url: 'https://www.makers.tech', title: 'Makers')
      expect(comment_class).to receive(:where).with(bookmark_id: bookmark.id)
      bookmark.comments(comment_class)
    end

  end

end
