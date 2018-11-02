require_relative('../db/sqlrunner')

class Screening

  attr_accessor :film_id, :remaining_tickets, :start_time

  attr_reader :id

  def initialize( params )
    @id = params['id'].to_i if params['id']
    @film_id = params['film_id'].to_i
    @remaining_tickets = params['remaining_tickets'].to_i
    @start_time = params['start_time']
  end

  # Class functions

  def self.delete_all
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM screenings WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    found_screening = Film.new(result[0])
    return found_screening
  end

  # Instance functions

  def save()
    sql = "INSERT INTO screenings (film_id, remaining_tickets, start_time) VALUES ($1, $2, $3) RETURNING id"
    values = [@film_id, @remaining_tickets, @start_time]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def update()
    sql = "UPDATE screenings SET (film_id, remaining_tickets, start_time) = ($1, $2, $3) WHERE id = $4"
    values = [@film_id, @remaining_tickets, @start_time, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM screeningss WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def tickets_sold
    sql = "SELECT COUNT (*) FROM tickets WHERE screening_id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results[0]['count'].to_i
  end

end