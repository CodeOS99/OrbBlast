extends CharacterBody2D


const SPEED = 300.0

func _process(delta: float) -> void:
	var angle = get_angle_to(get_global_mouse_position())
	$Pivot.rotation = lerp_angle($Pivot.rotation, angle+PI/2, 0.5)

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

	$Pivot/WalkParticles.visible = direction_vec.length() != 0

	move_and_slide()
