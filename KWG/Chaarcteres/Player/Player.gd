extends Character

class_name Player 
onready var detection_bar=$CanvasLayer/DetectionBar

#campo de vision
var detection_value=0.0
const MAX_LEVEL_DETECTTION=100


func _ready():
	$AnimationTree.active = true
	detection_bar.max_value=MAX_LEVEL_DETECTTION
	
# Cosa de deteccion

func _process(_delta):
	detection_bar.value=detection_value

func detection_level(delta):
	detection_value+=40*delta
	detection_bar.value=detection_value



#movimiento

func _get_input(delta):
	var target_velX = (Input.get_action_strength("RIGHT") - Input.get_action_strength("LEFT"))
	var target_velY = (Input.get_action_strength("DOWN") - Input.get_action_strength("UP"))
	lin_vel = move_and_slide(lin_vel)
	
	# VELOCIDAD EN X
	if target_velX != 0:
		lin_vel.x = lerp(lin_vel.x, target_velX * RUNSPEED, RUNACCEL * delta)
	else:
		lin_vel.x = lerp(lin_vel.x, 0, FRIC *delta)
	
	# VELOCIDAD EN Y
	if target_velY != 0:
		lin_vel.y = lerp(lin_vel.y, target_velY * RUNSPEED, RUNACCEL * delta)
	else:
		lin_vel.y = lerp(lin_vel.y, 0, FRIC * delta)

func _physics_process(delta:float)-> void:
	
	_get_input(delta)
	# pa donde mira (ROTA EL MONITO DE DERECHA A IZQUIERDA)
	if Input.is_action_pressed("LEFT") and not Input.is_action_pressed("RIGHT") and facing_right:
		facing_right = not facing_right
		scale.x *= -1
	if Input.is_action_pressed("RIGHT") and not Input.is_action_pressed("LEFT") and not facing_right:
		facing_right = not facing_right
		scale.x *= -1
	velocidad=move_and_slide(velocidad)
	#animaciones
	if lin_vel.length() >= 10:
		PLAYBACK.travel("Run")
	else:
		PLAYBACK.travel("IdleCat")


