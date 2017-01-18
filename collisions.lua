--[[
=======================================================================
title: Space Invaders Next - Copyright (c) 2017 Stefano Peris
version:0.3
license: MIT
author: Stefano Peris {TechnoPrometheus}
date: 17/01/2017
description: Space Invaders, alternative version.
notes: nothing
love_Engine_version: 0.10.2
=======================================================================
]]

function checkCollisions(enemies, bullets)
  for _, e in pairs(enemies) do
    for _, b in pairs(bullets) do
      if b.y <= e.y + e.height and b.y > e.x and b.x < e.x + e.width then
        print("COLLISION")
      end
    end
  end
end