extends CharacterBody2D

@export var speed = 150.0
var arrived = false

@onready var notifiers = $Notifiers

func _ready() -> void:
	get_tree().scene_changed.connect(self.queue_free)

func _physics_process(_delta: float) -> void:
	if not arrived:
		var flag = false
		for notifier in notifiers.get_children():
			if not notifier.is_on_screen():
				flag = true
		
		if not flag:
			arrived = true
			velocity = Vector2.ZERO
		else:
			var direction = global_position.direction_to(Globals.player.global_position)
			velocity = direction * speed
	
	if arrived:
		velocity = Vector2.ZERO 
		var angle = get_angle_to(Globals.player.global_position)
		$Pivot.rotation = lerp_angle($Pivot.rotation, angle+PI/2, 0.5)
		
	move_and_slide()
