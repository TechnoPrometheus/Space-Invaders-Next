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
enemy = {}
enemies_controller = {}
enemies_controller.enemies = {}
enemies_controller.image = love.graphics.newImage("img/enemy.png")

function love.load()
  player = {}
  player.x = 0
  player.y = 550 -- the bullet position.
  player.bullets = {}
  player.cooldown = 20
  player.speed = 5 -- Speed of scrolling of the player.
  player.fire = function()
    if player.cooldown <= 0 then
      player.cooldown = 20
      bullet = {}
      bullet.x = player.x +35 -- bullets spawn position.
      bullet.y = player.y
      table.insert(player.bullets, bullet)
    end
  end
  enemies_controller:spawnEnemy(0, 0)
  enemies_controller:spawnEnemy(100, 0)
end

function enemies_controller:spawnEnemy(x, y)
  enemy = {}
  enemy.x = x
  enemy.y = y -- the enemy position.
  enemy.bullets = {}
  enemy.cooldown = 20
  enemy.speed = 5 -- Speed of scrolling of the enemy.
  table.insert (self.enemies, enemy)
end

function enemy:fire()
  if self.cooldown <= 0 then
    self.cooldown = 20
    bullet = {}
    bullet.x = self.x +35 -- bullets spawn position..
    bullet.y = self.y
    table.insert(self.bullets, bullet)
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

  for _,e in pairs(enemies_controller.enemies) do
    e.y = e.y +1
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
  love.graphics.setColor(0, 0, 255, alpha) -- player color (RGB)
  love.graphics.rectangle("fill", player.x, player.y, 80, 20)

  -- draw enemies
  love.graphics.setColor(255, 0, 0, alpha) -- enemy color (RGB)
  for _,e in pairs(enemies_controller.enemies) do
    love.graphics.rectangle("fill", e.x, e.y, 80, 20)
  end

  -- draw bullets
  love.graphics.setColor(255, 255, 255, alpha) -- bullets color (RGB).

  for _,b in pairs(player.bullets) do
    love.graphics.rectangle("fill", b.x, b.y, 10, 10)
  end
end
