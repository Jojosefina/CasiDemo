extends KinematicBody2D




var facing_right = true
var facing_down= true
onready var PLAYBACK = $AnimationTree.get("parameters/playback")


func _physics_process(_delta: float)-> void:
	velocidad=move_and_slide(velocidad)
	velocidad=lerp(velocidad, Vector2.ZERO, FRIC)

func move()-> void:
	lin_vel=lin_vel.normalized()
	velocidad+=lin_vel*RUNACCEL

