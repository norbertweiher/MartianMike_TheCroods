extends Control


func _on_btn_start_game_pressed():
	get_tree().change_scene_to_file("res://Levels/sophia_1_st_level.tscn")


func _on_btn_quit_pressed():
	get_tree().quit()
