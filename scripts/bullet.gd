extends Node2D

var SPEED = 500

func _ready() -> void:
	get_tree().scene_changed.connect(self.queue_free)

func _process(delta: float) -> void:
	var direction = Vector2.UP.rotated(rotation)
	global_position += direction * SPEED * delta
