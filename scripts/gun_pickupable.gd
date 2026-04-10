extends Node2D

func _process(delta: float) -> void:
	if $Label.visible: # player in
		if Input.is_action_just_pressed("pickup"):
			Globals.player.pickup_gun()
			self.queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$Label.visible = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$Label.visible = false
