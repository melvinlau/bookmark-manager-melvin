class User

  def self.create(email:, password:)
    # Encrypt the plaintext password
    encrypted_password = BCrypt::Password.create(password)
    # Insert the encrypted password into the database
    sql = "INSERT INTO users (email, password) VALUES('#{email}','#{encrypted_password}') RETURNING id, email"
    result = DatabaseConnection.query(sql)
    User.new(
      id: result[0]['id'],
      email: result[0]['email']
    )
  end

  def self.find(id)
    return nil unless id
    sql = "SELECT * FROM users WHERE id = '#{id}'"
    result = DatabaseConnection.query(sql)
    User.new(id: result[0]['id'], email: result[0]['email'])
  end

  def self.authenticate(email:, password:)
    sql = "SELECT * FROM users WHERE email = '#{email}';"
    result = DatabaseConnection.query(sql)
    return nil unless result.any? # Guard clause against nonexistent email in dbase
    User.new(id: result[0]['id'], email: result[0]['email'])
  end

  attr_reader :id, :email

  def initialize(id:, email:)
    @id = id
    @email = email
  end

end
