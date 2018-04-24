require("pry")
require_relative("models/bounty")
Bounty.delete_all()
bounty1 = Bounty.new({
  "name" => "Boba Fett",
  "bounty_value" => 1_000_000,
  "homeworld" => "Kamino",
  "favourite_weapon" => "blaster"
  })
bounty1.save()

bounty2 = Bounty.new({
  "name" => "Django Fett",
  "bounty_value" => 2_000_000,
  "homeworld" => "Concord Dawn",
  "favourite_weapon" => "lightsaber"
  })
bounty2.save()

bounties = Bounty.select_all()
binding.pry
nil
