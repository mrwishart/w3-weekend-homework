require_relative('../db/sqlrunner')

class Customer

  attr_accessor :name
  attr_reader :id, :wallet

  def initialize( params )
    @id = params['id'].to_i if params['id']
    @name = params['name']
    @wallet = params['wallet'].to_f.round(2)
  end

  def save()
    sql = "INSERT INTO customers (name, wallet) VALUES ($1, $2) RETURNING id"
    values = [@name, @wallet]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

end
