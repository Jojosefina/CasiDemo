extends Node2D

class_name AI

signal cambio_de_estado(nuevo_estado)

onready var visual= $Campo_de_vision
onready var zona_agro=$zona_de_agro
onready var timer_agro=$tiempo_agro

enum State{ PATRULLAR,
	AGRO
}

var current_state: int= State.PATRULLAR setget set_state
var player: Player = null
var target
var actor=null

func initialize(actor):
	self.actor=actor

func _process(delta:float)-> void:
	match current_state:
		State.PATRULLAR:
			pass
		State.AGRO:
			if is_instance_valid(player):
				actor.velocity = (player.position-actor.position).normalized() * actor.run_speed
				if target :
					player.detection_level(delta)
			else:
				actor.velocity = Vector2.ZERO
			actor._chase(actor.velocity)


	
func set_state(new_state:int):
	if new_state == current_state:
		return
	current_state=new_state
	emit_signal("cambio_de_estado",current_state)



func _on_Campo_de_vision_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		set_state(State.AGRO)
		player=body
		target=true
		timer_agro.stop()


func _on_Campo_de_vision_body_exited(body):
	if player and body==player:
		timer_agro.start()
		target=false
		


func _on_zona_de_agro_body_exited(body):
	if body==player:
		player=null
		

func _on_zona_de_agro_body_entered(body):
	if player and body==player:
		print(timer_agro.time_left)
		if timer_agro.is_stopped():
			player=null

func _on_tiempo_agro_timeout():
	player=null
