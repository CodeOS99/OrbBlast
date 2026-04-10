extends Button


func _on_pressed() -> void:
	Globals.score = 0
	get_tree().change_scene_to_file("res://scenes/main_game_area.tscn")
