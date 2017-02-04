class Pokemon
  attr_accessor :id, :name, :type, :db, :hp

  def initialize(id: id, name: name, type: type, db: db)
    @id = id
    @name = name
    @type = type
    @db = db
  end

  def self.save(name, type, db)
    db.execute("INSERT INTO pokemon(name, type) VALUES (?, ?)", [name, type])
  end

  def self.find(id, db)
    result = db.execute("SELECT * FROM pokemon WHERE id=?", id)[0]
    new(id: result[0], name: result[1], type: result[2], db: db).tap do |o|
      if  result.length > 2
        o.hp = result[3]
      end
    end
  end

  def alter_hp(new_hp, db)
    db.execute("UPDATE pokemon SET hp=? WHERE id=?", [new_hp, @id])
  end
end
