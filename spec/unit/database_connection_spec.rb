require 'database_connection'
describe DatabaseConnection do
  describe '.setup' do
    it 'sets up a connection to database via PG' do
      expect(PG).to receive(:connect).with(dbname: 'bookmark_manager_test')
      described_class.setup('bookmark_manager_test')
    end
  end
end
