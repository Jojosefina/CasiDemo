extends Character
class_name Enemy

var run_speed = 60
var velocity = Vector2.ZERO
var path: PoolVector2Array

# guion bajo se refiere a funciones override 

onready var timer= $Timer


var player 
var target


func _ready():
	timer.connect("timeout",self, "on_timeout")
	$AnimationTree.active = true
	var _er1=$Campo_de_vision.connect("body_entered",self,"on_body_enter")
	var _er2=$Campo_de_vision.connect("body_exited",self,"on_body_out")
	
	var _er4=$zona_de_agro.connect("body_exited",self,"out_agro")


func on_timeout():
	player=null

func on_body_enter(body):
	if body is Player:
		timer.stop()
		player=body
		target=true

func on_body_out(body):
	if body==player:
		timer.start()
		target=false

func out_agro(body):
	if body==player:
		player=null


func _physics_process(delta):
	#chase
	if is_instance_valid(player):
		velocity = position.direction_to(player.position) * run_speed
		if target :
			player.detection_level(delta)
	else:
		velocity = Vector2.ZERO
	velocity = move_and_slide(velocity)





