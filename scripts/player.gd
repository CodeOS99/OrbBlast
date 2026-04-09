extends CharacterBody2D

const SPEED = 300.0

var bullet := preload("res://scenes/bullet.tscn")

var last_mouse_pos := Vector2.ZERO
var mouse_move_threshold := 0.1

func _process(delta: float) -> void:
	var angle = get_angle_to(get_global_mouse_position())
	$Pivot.rotation = lerp_angle($Pivot.rotation, angle+PI/2, 0.5)

	if Input.is_action_just_pressed("shoot"):
		var bullet_instance = bullet.instantiate()
		get_tree().root.add_child(bullet_instance)
		bullet_instance.global_position = $Pivot/BulletPoint.global_position
		bullet_instance.rotation = $Pivot.rotation

func _physics_process(delta: float) -> void:
	var direction_vec := Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
		)
	if direction_vec.x:
		velocity.x = direction_vec.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED/16)
		
	if direction_vec.y:
		velocity.y = direction_vec.y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED/16)
	
	update_time_scale(direction_vec)

	$Pivot/WalkParticles.visible = direction_vec.length() != 0

	move_and_slide()
	
	last_mouse_pos = get_global_mouse_position()

func update_time_scale(direction_vec):	
	if direction_vec.length() != 0:
		Engine.time_scale = 1
	elif is_mouse_moving():
		Engine.time_scale = .5
	else:
		Engine.time_scale = .1

func is_mouse_moving():
	var current_mouse_pos = get_global_mouse_position()
	var mouse_vel = current_mouse_pos.distance_to(last_mouse_pos)
	
	return mouse_vel > mouse_move_threshold
