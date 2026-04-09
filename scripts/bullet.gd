extends Node2D

var SPEED = 500

func _ready() -> void:
	get_tree().scene_changed.connect(self.queue_free)

func _process(delta: float) -> void:
	self.global_position += global_transform.basis_xform(Vector2(0, -SPEED*delta))
