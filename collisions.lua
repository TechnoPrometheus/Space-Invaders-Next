

function checkCollisions(enemies, bullets)
  for _, e in pairs(enemies) do
    for _, b in pairs(bullets) do
      if b.y <= e.y + e.height and b.y > e.x and b.x < e.x + e.width then
        print("COLLISION")
      end
    end
  end
end