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
enemies_controller.image = love.graphics.newImage("img/InvaderB_01.png")
love.graphics.getDefaultFilter("nearest", "nearest")

function enemies_controller:spawnEnemy(x, y)
  enemy = {}
  enemy.x = x
  enemy.y = y -- the enemy position.
  enemy.bullets = {}
  enemy.cooldown = 20
  enemy.speed = 2 -- Speed of scrolling of the enemy.
  table.insert (self.enemies, enemy)
end

function enemy:fire()
  if self.cooldown <= 0 then
    self.cooldown = 20
    bullet = {}
    bullet.x = self.x +35 -- bullets spawn position.
    bullet.y = self.y
    table.insert(self.bullets, bullet)
  end
end