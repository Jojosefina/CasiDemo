extends KinematicBody2D

var lin_vel = Vector2.ZERO

#campo de vision
var detection_value=0.0
const MAX_LEVEL=100
#
export var RUNSPEED = 100
export var RUNACCEL = 15
export var FRIC = 30
var facing_right = true
onready var PLAYBACK = $AnimationTree.get("parameters/playback")
onready var PROGRESS_BAR=get_parent().get_node("ProgressBar")


# Inicializa al gatito con movimiento
func _ready():
	$AnimationTree.active = true
	PROGRESS_BAR.max_value=MAX_LEVEL

func _process(_delta):
	PROGRESS_BAR.value=detection_value

func _physics_process(delta):
	var target_velX = (Input.get_action_strength("RIGHT") - Input.get_action_strength("LEFT"))
	var target_velY = (Input.get_action_strength("DOWN") - Input.get_action_strength("UP"))
	lin_vel = move_and_slide(lin_vel)
	
	# VELOCIDAD EN X
	if target_velX != 0:
		lin_vel.x = lerp(lin_vel.x, target_velX * RUNSPEED, RUNACCEL * delta)
	else:
		lin_vel.x = lerp(lin_vel.x, 0, FRIC * delta)
	
	# VELOCIDAD EN Y
	if target_velY != 0:
		lin_vel.y = lerp(lin_vel.y, target_velY * RUNSPEED, RUNACCEL * delta)
	else:
		lin_vel.y = lerp(lin_vel.y, 0, FRIC * delta)
	
	# pa donde mira (ROTA EL MONITO DE DERECHA A IZQUIERDA)
	if Input.is_action_pressed("LEFT") and not Input.is_action_pressed("RIGHT") and facing_right:
		facing_right = not facing_right
		scale.x *= -1
	if Input.is_action_pressed("RIGHT") and not Input.is_action_pressed("LEFT") and not facing_right:
		facing_right = not facing_right
		scale.x *= -1
	
	#ANIMATIONS (RUN/IDLE/ETC)
	if lin_vel.length() >= 10:
		PLAYBACK.travel("Run")
	else:
		PLAYBACK.travel("IdleCat")
		

func detection_level(delta):
	detection_value+=delta
	print(detection_value)
	
	
