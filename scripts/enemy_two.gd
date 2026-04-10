extends CharacterBody2D

@export var speed = 150.0
@export var health = 1

var arrived = false

var bullet := preload("res://scenes/bullet_enemy.tscn")
var particles = preload("res://scenes/explosion.tscn")
var gun_pickupable = preload("res://scenes/gun_pickupable.tscn")

@onready var notifiers = $Notifiers
@onready var pivot = $Pivot

var shoot_timer = 0.0

func _ready() -> void:
	get_tree().scene_changed.connect(self.queue_free)

func _physics_process(delta: float) -> void:
	if not arrived:
		var flag = false
		for notifier in notifiers.get_children():
			if not notifier.is_on_screen():
				flag = true
		
		if not flag:
			arrived = true
			velocity = Vector2.ZERO
		else:
			if speed:
				var direction = global_position.direction_to(Globals.player.global_position)
				velocity = direction * speed
	
	if arrived:
		velocity = Vector2.ZERO 
		var angle = get_angle_to(Globals.player.global_position)
		pivot.rotation = lerp_angle(pivot.rotation, angle + PI/2, 0.5)
		
		shoot_timer += delta
		if shoot_timer >= 2.0:
			shoot_at_player()
			shoot_timer = 0.0
			
	move_and_slide()

func shoot_at_player():
	if bullet:
		var bullet_instance = bullet.instantiate()
		get_tree().root.add_child(bullet_instance)
		
		bullet_instance.global_position = $Pivot/BulletPoint.global_position
		bullet_instance.global_rotation = $Pivot.global_rotation

func damage():
	health -= 1
	if health <= 0:
		destroy()
	
	var instance = particles.instantiate()
	instance.emitting = true
	get_tree().root.add_child(instance)
	instance.global_position = self.global_position

func destroy():
	if not is_instance_valid(self):
		return
	
	# Particle emmition
	var instance = particles.instantiate()
	instance.emitting = true
	get_tree().root.add_child(instance)
	instance.global_position = self.global_position
	
	# Gun Check
	if randf() <= .5:
		var drop = gun_pickupable.instantiate()
		get_tree().root.add_child(drop)
		drop.global_position = self.global_position
	Globals.score+=1
	self.queue_free()
