class User
  def self.create(email:, password:)
    sql = "INSERT INTO users (email, password) VALUES('#{email}','#{password}') RETURNING id, email"
    result = DatabaseConnection.query(sql)
    User.new(
      id: result[0]['id'],
      email: result[0]['email']
    )
  end

  attr_reader :id, :email

  def initialize(id:, email:)
    @id = id
    @email = email
  end
  
end
