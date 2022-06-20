extends Control
onready var opt_menu = $OptionsMenu
onready var video_menu = $OptionsMenu/VBoxContainer/SetBtn/Video




func _on_Start_pressed():
	get_tree().change_scene("res://Game.tscn")



func _on_Quit_pressed():
	get_tree().quit()
	


func _on_Options_pressed():
	opt_menu.popup_centered()
	
