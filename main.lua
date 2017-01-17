--[[
=======================================================================
title: Space Invaders Next
description: Space Invaders, alternative version.
author: Stefano Peris
date: 17/01/2017
version:0.1
notes: nothing
love_Engine_version: 0.10.2
=======================================================================
]]

function love.load()
  player = {}
  player.x = 0
  player.bullets = {}
  player.cooldown = 20
  player.fire = function()
    if player.cooldown <= 0 then
      player.cooldown = 20
      bullet = {}
      bullet.x = player.x +35
      bullet.y = 400
      table.insert(player.bullets, bullet)
    end
  end
end

function love.update(dt)
  player.cooldown = player.cooldown - 1

  if love.keyboard.isDown("right") then
    player.x = player.x + 1 -- Valore intero positivo, permette di spostarsi a destra.
  elseif love.keyboard.isDown("left") then
    player.x = player.x - 1 -- Valore intero negativo, permette di spostarsi a sinistra.
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
  love.graphics.setColor(0, 0, 255, alpha) -- Colorazione rettangolo (RGB)
  love.graphics.rectangle("fill", player.x, 400, 80, 20)
  love.graphics.setColor(255, 255, 255, alpha) -- Colorazione proiettile (RGB).

  for _,b in pairs(player.bullets) do
    love.graphics.rectangle("fill", b.x, b.y, 10, 10)
  end
end
