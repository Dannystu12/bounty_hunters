require('pg')
class Bounty
  attr_accessor(:name, :bounty_value, :homeworld, :favourite_weapon)
  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
    @bounty_value = options["bounty_value"].to_i
    @homeworld = options["homeworld"]
    @favourite_weapon = options["favourite_weapon"]
  end

  def save
    db = PG.connect({
      dbname: "bounty_hunters",
      host: "localhost"
      })
    sql = "INSERT INTO bounties
    (name, bounty_value, homeworld, favourite_weapon)
    VALUES($1, $2, $3, $4) RETURNING id"
    values = [@name, @bounty_value, @homeworld, @favourite_weapon]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]["id"].to_i
    db.close()
  end

  def update
    db = PG.connect({
      dbname: "bounty_hunters",
      host: "localhost"
      })
    sql = "UPDATE bounties SET (name, bounty_value, homeworld, favourite_weapon) = ($1, $2, $3, $4) WHERE id = $5"
    values = [@name, @bounty_value, @homeworld, @favourite_weapon, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def delete
    db = PG.connect({
      dbname: "bounty_hunters",
      host: "localhost"
      })
    sql = "DELETE FROM bounties WHERE id = $1"
    db.prepare("delete", sql)
    db.exec_prepared("delete", [@id])
    db.close()
  end

  def self.find_by_name(name)
    db = PG.connect({
      dbname: "bounty_hunters",
      host: "localhost"
      })
    sql = "SELECT * FROM bounties WHERE name = $1 LIMIT 1"
    db.prepare("find_by_name", sql)
    result = db.exec_prepared("find_by_name", [name])
    db.close()
    return result.ntuples() == 0 ? nil : Bounty.new(result[0])
  end

  def self.find_by_id(id)
    db = PG.connect({
      dbname: "bounty_hunters",
      host: "localhost"
      })
    sql = "SELECT * FROM bounties WHERE id = $1 LIMIT 1"
    db.prepare("find_by_id", sql)
    result = db.exec_prepared("find_by_id", [id])
    db.close()
    return result.ntuples() == 0 ? nil : Bounty.new(result[0])
  end

  def self.select_all
    db = PG.connect({
      dbname: "bounty_hunters",
      host: "localhost"
      })
    sql = "SELECT * FROM bounties"
    db.prepare("select_all", sql)
    bounties = db.exec_prepared("select_all").map{|hash| Bounty.new(hash)}
    db.close()
    return bounties
  end

  def self.delete_all
    db = PG.connect({
      dbname: "bounty_hunters",
      host: "localhost"
      })

    sql = "DELETE FROM bounties"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end
end
