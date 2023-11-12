extends CharacterBody2D


const SPEED = 300.0
#const JUMP_VELOCITY = -400.0
var original_x = position.x
#var original_position = position
# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var position_flotter = get_parent().get_node('MarkerEpee').position

func _physics_process(delta):
	var collision = move_and_collide(velocity.normalized() * delta * SPEED)
	
	#if position.x - $CharacterCountess.position.x > 400:
	#	retourner()
	if collision:
		#print(collision.get_collider().name)
		# Si on a heurté un ennemi, indiquer à l'ennemi qu'il s'est fait heurté
		if collision.get_collider().name == 'Ennemi':
			print("oof")
		elif collision.get_collider().name == 'CharacterCountess':
			flotter()
		#L'épée reviens après une collision 
		else:
			retourner()


func lancer():
	$TimerRetour.start()

func _on_timer_retour_timeout():
	retourner()

func retourner():
	$TimerRetour.stop()
	print("retour")
	rotation = 180
	velocity = Vector2(-1, 0)

func flotter():
	position = position_flotter
	velocity = Vector2(0, 0)
	rotation = 0
