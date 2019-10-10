require_relative 'database_helpers'
require 'user'

describe User do
  describe '.create' do
    it 'creates a new user' do
      user = User.create(email: 'melvin@melvin.com', password: '12345')
      persisted_data = persisted_data(table: 'users', id: user.id)

      expect(user).to be_a User
      expect(user.id).to eq persisted_data.first['id']
      expect(user.email).to eq 'melvin@melvin.com'
    end
  end
end
