--[[
=======================================================================
title: Space Invaders Next - Copyright (c) 2017 Stefano Peris
version:0.2
license: MIT
author: Stefano Peris {TechnoPrometheus}
date: 17/01/2017
description: Space Invaders, alternative version.
notes: nothing
love_Engine_version: 0.10.2
=======================================================================
]]

function love.load()
  player = {}
  player.x = 0
  player.y = 550 -- the projectile position.
  player.bullets = {}
  player.cooldown = 20
  player.speed = 5 -- Speed of scrolling of the player.
  player.fire = function()
    if player.cooldown <= 0 then
      player.cooldown = 20
      bullet = {}
      bullet.x = player.x +35 -- bullets spawn position..
      bullet.y = player.y
      table.insert(player.bullets, bullet)
    end
  end
end

function love.update(dt)
  player.cooldown = player.cooldown - 1

  if love.keyboard.isDown("right") then
    player.x = player.x + player.speed
  elseif love.keyboard.isDown("left") then
    player.x = player.x - player.speed
  end

  if love.keyboard.isDown("space") then
    player.fire()
  end

  for i,b in ipairs(player.bullets) do
    if b.y < -10 then
      table.remove(player.bullets, i)
  end

  b.y = b.y - 5
  end
end

function love.draw()
  -- draw player
  love.graphics.setColor(0, 0, 255, alpha) -- Colorazione rettangolo (RGB)
  love.graphics.rectangle("fill", player.x, player.y, 80, 20)

  -- draw bullets
  love.graphics.setColor(255, 255, 255, alpha) -- Colorazione proiettile (RGB).

  for _,b in pairs(player.bullets) do
    love.graphics.rectangle("fill", b.x, b.y, 10, 10)
  end
end
