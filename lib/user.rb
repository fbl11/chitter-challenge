require 'pg'

class User
  attr_reader :id, :name, :email, :password

  def initialize(id:, name:, email:, password:)
    @id = id
    @name = name
    @email = email
    @password = password
  end

  def self.all
    result = db_access.exec("SELECT * FROM users;")
    result.map do |user|
      User.new(id: user['id'], name: user['name'], email: user['email'],
        password: user['password'])
    end
  end

  def self.create(name:, email:, password:)
    result = db_access.exec("INSERT INTO users (name, email, password) VALUES(
      '#{db_access.escape_string(name)}', '#{db_access.escape_string(email)}',
      '#{db_access.escape_string(password)}')
       RETURNING id, name, email, password;")
    User.new(id: result[0]['id'], name: result[0]['name'],
      email: result[0]['email'], password: result[0]['password'])
  end

  def self.find(id:)
    return nil unless id
    result = db_access.exec("SELECT * FROM users WHERE id = '#{id}';")
    User.new(id: result[0]['id'], name: result[0]['name'], 
      email: result[0]['email'], password: result[0]['password'])
  end

  private_class_method

  def self.db_access
    if ENV['RACK_ENV'] == 'test'
      PG.connect(dbname: 'chitter_test')
    else
      PG.connect(dbname: 'chitter')     
    end
  end

end