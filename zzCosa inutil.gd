extends Control


func _on_play_pressed():
	get_tree().change_scene_to_packed(preload("res://scenes/levels/0-1.tscn"))
#
#func _on_option_pressed():
	# control cript del menu 
	# get_tree().change_scene_to_file("res://scenes//Options.tscn")

func _on_exit_pressed():
	get_tree().quit()
