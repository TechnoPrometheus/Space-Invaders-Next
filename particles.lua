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

function particle_systems:spawn(x, y)
  local ps = {}
  ps.x = x
  ps.y = y
  ps.ps = love.graphics.newParticleSystem(particle_systems.img, 32)
  ps.ps:setParticleLifetime(2, 4)
  ps.ps:setEmissionRate(5)
  ps.ps:setSizeVariation(1)
  ps.ps:setLinearAcceleration(-20, -20, 20, 20)
  ps.ps:setColors(100, 255, 100, 255, 0, 255, 0, 255)
  table.insert(particle_systems.list, ps)
end

function particle_systems:draw()
  for _, v in pairs(particle_systems.list) do
    love.graphics.draw(v.ps, v.x, v.y)
  end
end

function particle_systems:update(dt)
  for _, v in pairs(particle_systems.list) do
    v.ps:update(dt)
  end
end

function particle_systems:cleanup()
  -- delete particle systems after a length of time...
  -- exercise left for the viewer ;)
end