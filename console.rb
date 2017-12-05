require('./models/bounty.rb')

bounty1 = Bounty.new( "name" => "Vicotira",
                      "bounty_value" => "500",
                      "danger_level" => "4/10",
                      "last_known_location" => "Vegas Station"
                      )

bounty1.save()

bounty1.bounty_value = 700

Bounty.update(bounty1)

# binding.pry()
nil
