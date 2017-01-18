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

require "conf"
require("enemy")
require "collisions"
require("particles")

function love.load()
  local music = love.audio.newSource("sound/music.mp3")
  music:setLooping(true)
  love.audio.play(music)
  game_over = false
  game_win = false
  background_image = love.graphics.newImage("img/bg.jpg")
  player = {}
  player.x = 0
  player.y = 270 -- the bullet position.
  player.bullets = {}
  player.cooldown = 20
  player.speed = 2 -- Speed of scrolling of the player.
  player.image = love.graphics.newImage("img/Ship.png")
  player.fire_sound = love.audio.newSource("sound/ShipBullet.wav")
  player.fire = function()
    if player.cooldown <= 0 then
    love.audio.play(player.fire_sound)
      player.cooldown = 20
      bullet = {}
      bullet.x = player.x +14 -- bullet spawn horizontal position.
      bullet.y = player.y +1 -- bullet spawn vertical position.
      table.insert(player.bullets, bullet)
    end
  end
  for i = 0, 10 do
  enemies_controller:spawnEnemy(i * 15, 0)
  end
end

function love.update(dt)
  particle_systems:update(dt)
  player.cooldown = player.cooldown - 1

  if love.keyboard.isDown("right") then
    player.x = player.x + player.speed
  elseif love.keyboard.isDown("left") then
    player.x = player.x - player.speed
  end

  if love.keyboard.isDown("space") then
    player.fire()
  end
  
  if #enemies_controller.enemies == 0 then
    -- we win!
    game_win = true
  end

  for _,e in pairs(enemies_controller.enemies) do
    if e.y >= love.graphics.getHeight()/4 then
      game_over = true
    end
    e.y = e.y + 1 * e.speed
  end

  for i,b in ipairs(player.bullets) do
    if b.y < -10 then
      table.remove(player.bullets, i)
  end
  b.y = b.y - 3 -- bullet speed.
  end
  checkCollisions(enemies_controller.enemies, player.bullets)
end

function love.draw()
  love.graphics.scale(2)
  love.graphics.draw(background_image)
  if game_over then
    love.graphics.print("Game Over!")
    return
  elseif game_win then
    love.graphics.print("You Won!")
    -- we'll leave the return out so that we get to shoot
    -- victoriously into space
  end
  
  particle_systems:draw()

  -- draw player
  love.graphics.setColor(255, 255, 255, alpha) -- player color (RGB)
  love.graphics.draw(player.image, player.x, player.y)

  -- draw enemies
  love.graphics.setColor(255, 255, 255, alpha) -- enemy color (RGB)
  for _,e in pairs(enemies_controller.enemies) do
    love.graphics.draw(enemies_controller.image, e.x, e.y, 0)
  end

  -- draw bullets
  love.graphics.setColor(255, 255, 255, alpha) -- bullets color (RGB).
  for _,b in pairs(player.bullets) do
    love.graphics.rectangle("fill", b.x, b.y, 2, 2)
  end
end
