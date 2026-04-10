extends CharacterBody2D

const CHASE_SPEED = 150.0
const DASH_SPEED = 300.0
const DASH_THRESHOLD = 200

var target_pos = Vector2.ZERO

var speed = CHASE_SPEED

var particles = preload("res://scenes/explosion.tscn")

@export var health = 1

func _process(delta: float) -> void:
	var angle = get_angle_to(Globals.player.global_position)
	$Pivot.rotation = lerp_angle($Pivot.rotation, angle + PI/2, 0.1)
	
	if global_position.distance_to(Globals.player.global_position) < DASH_THRESHOLD and target_pos == Vector2.ZERO:
		speed = DASH_SPEED
		$Ellipse.fill_color = Color(3.409, 1.851, 0.0)
		target_pos = Globals.player.global_position

func _physics_process(delta: float) -> void:
	if (target_pos != Vector2.ZERO and self.global_position.distance_to(target_pos) < 1):
		destroy()
	
	var dir = global_position.direction_to(Globals.player.global_position if target_pos == Vector2.ZERO else target_pos)
	velocity = dir * speed
	
	move_and_slide()

func damage():
	health -= 1
	if health <= 0:
		destroy()
	
	var instance = particles.instantiate()
	instance.emitting = true
	get_tree().root.add_child(instance)
	instance.global_position = self.global_position

func destroy():
	var instance = particles.instantiate()
	instance.emitting = true
	get_tree().root.add_child(instance)
	instance.global_position = self.global_position
	self.queue_free()
