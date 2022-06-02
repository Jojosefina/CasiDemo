extends Node

func _ready():
	pass # Replace with function body.

func _on_Area2D_body_entered(body):
	if(body.is_in_group("player")):
		get_tree().get_nodes_in_group("nivel")[0].queue_free()
		load_level()
		

