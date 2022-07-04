extends Character
class_name Enemy

# fisicas
var run_speed = 60
var velocity = Vector2.ZERO
var path: PoolVector2Array
var knockback_vector=Vector2.ZERO
var knockback_force = 200
#ai
onready var ai=$AI
#persecucion y ataques
onready var timer_agro= $tiempo_agro
onready var visual=$AI/Campo_de_vision
onready var zona_agro=$AI/zona_de_agro
onready var melee_area=$melee_area
#salud
onready var health_stat= $Salud

#variables
var player 
var target

func _ready()-> void:
	$AnimationTree.active = true
	ai.initialize(self)

func _physics_process(delta):
	var attacking = false
	knockback_vector=knockback_vector.move_toward(Vector2.ZERO,knockback_force*delta)
	knockback_vector=move_and_slide(knockback_vector)
	if attacking:
		pass
	if not attacking:
		if velocity.length() >= 5:
			PLAYBACK.travel("run")
		else:
			PLAYBACK.travel("Idle")

func _chase(velocity):
	move_and_slide(velocity)

func handle_hit(_knockback:Vector2):
	health_stat.health-=20
	if health_stat.health <=0:
		queue_free()
	knockback_vector=_knockback*knockback_force
	print('enemigo dañado', health_stat.health)
	print(knockback_vector)




