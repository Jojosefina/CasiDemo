extends Node

#export (PackedScene) var nivel1
#export (PackedScene) var nivel2


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func load_level():
	if(Gamehandler.nivel_actual == nivel1):
		newlevel = nivel1.instance()
	elif(Gamehandler.nivel_actual == nivel2):
		newlevel = nivel2.instance()
		
	add_child(newlevel)
	
func next_level():
		Gamehandler.nivel_actual += 1
		load_level()
		
