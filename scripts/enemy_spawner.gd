extends Node2D

const INTERVAL = 2.0
const MIN_SPAWN_DISTANCE = 300.0
const MAX_SPAWN_DISTANCE = 600.0

var curr = INTERVAL

var enemies = [preload("res://scenes/enemy_two.tscn")]

func _process(delta: float) -> void:
	curr -= delta
	
	if curr <= 0:
		curr = INTERVAL
		spawn_enemy()

func spawn_enemy():
	var instance = enemies.pick_random().instantiate()
	
	var random_dir = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var random_dist = randf_range(MIN_SPAWN_DISTANCE, MAX_SPAWN_DISTANCE)
	
	get_tree().root.add_child(instance)
	
	instance.global_position = Globals.player.global_position + random_dir * random_dist
