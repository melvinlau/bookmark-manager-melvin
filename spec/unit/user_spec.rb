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

    it 'hashes the password using Bcrypt' do
      expect(BCrypt::Password).to receive(:create).with('12345')
      User.create(email: 'melvin@melvin.com', password: '12345')
    end
  end

  describe '.find' do
    it 'finds a user by ID and returns the user instance' do
      user = User.create(email: 'melvin@melvin.com', password: '12345')
      result = User.find(user.id)
      expect(result.id).to eq user.id
      expect(result.email).to eq user.email
    end

    it 'returns nil if there is no ID given' do
      expect(User.find(nil)).to eq nil
    end
  end

  describe '.authenticate' do
    it 'returns a user given a correct username and password, if user exists' do
      user = User.create(email: 'melvin@melvin.com', password: '12345')
      authenticated_user = User.authenticate(email: 'melvin@melvin.com', password: '12345')
      expect(authenticated_user.id).to eq user.id
    end

    it 'returns nil given an incorrect email' do
      user = User.create(email: 'melvin@melvin.com', password: '12345')
      expect(User.authenticate(email: 'hello@melvin.com', password: '12345')).to be_nil
    end

    it 'returns nil given an incorrect password' do
      user = User.create(email: 'melvin@melvin.com', password: '12345')
      expect(User.authenticate(email: 'melvin@melvin.com', password: 'abc123')).to be_nil
    end
  end


end
