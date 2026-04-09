extends CharacterBody2D


const SPEED = 300.0

func _process(delta: float) -> void:
	var angle = get_angle_to(get_global_mouse_position())
	$Pivot.rotation = lerp_angle($Pivot.rotation, angle+PI/2, 0.5)

func _physics_process(delta: float) -> void:
	var direction_arr := [
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
		]
	if direction_arr[0]:
		velocity.x = direction_arr[0] * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED/16)
		
	if direction_arr[1]:
		velocity.y = direction_arr[1] * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED/16)

	move_and_slide()
