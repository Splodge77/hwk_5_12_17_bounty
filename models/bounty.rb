require('pg')
require('pry-byebug')

class Bounty

  attr_accessor :name, :bounty_value, :danger_level,
  :last_known_location

  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @bounty_value = options['bounty_value'].to_i
    @danger_level = options['danger_level']
    @last_known_location = options['last_known_location']
  end


  def save()
    db = PG.connect({ dbname: 'bounty_hunters', host: 'localhost'})
    sql = "
    INSERT INTO bounties (
      name, bounty_value, danger_level, last_known_location)
    VALUES ($1, $2, $3, $4)
    RETURNING *;
    "
    values = [@name, @bounty_value, @danger_level, @last_known_location]
    #binding.pry
    db.prepare("save", sql)
    #binding.pry
    @id = db.exec_prepared("save", values)[0]['id']
    db.close()
  end

  def self.update(bounty)
    id = bounty.id.to_s
    name = bounty.name
    bounty_value = bounty.bounty_value.to_s
    danger_level = bounty.danger_level
    last_known_location = bounty.last_known_location
    db = PG.connect({ dbname: 'bounty_hunters', host: 'localhost'})
    sql = "
    UPDATE bounties SET
      name = $1, bounty_value = $2, danger_level = $3, last_known_location = $4  
    WHERE id = $5;
    "
    values = [name, bounty_value, danger_level, last_known_location, id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close
  end


end
