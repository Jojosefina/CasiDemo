extends KinematicBody2D

var player

# guion bajo se refiere a funciones override 

func _ready():
	var _er1=$Area2D.connect("body_entered",self,"on_body_enter")
	var _er2=$Area2D.connect("body_exited",self,"on_body_out")
	
func on_body_enter(body):
	player=body

func on_body_out(body):
	if body==player:
		player=null

func _physics_process(delta):
	if is_instance_valid(player):
		player.detection_level(delta)
