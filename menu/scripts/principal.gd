extends Control


func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/0-1.tscn")

func _on_option_pressed():
	  
	get_tree().change_scene_to_file("res://menu/config.tscn")

func _on_exit_pressed():
	get_tree().quit()
