extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const DASH_VELOCITY = 200

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var nbsauts = 0
var next_animation = ""
var current_animation = ""

var hp = 100

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Gérer le dash 
	if $TimerDash.is_stopped():
		if Input.is_action_just_pressed("dash"):
			dash()
			#Recommencer l'attente de 1 seconde puis arrêter le timer
			$TimerDash.start()
			await $TimerDash.timeout
			$TimerDash.stop()
	#if Input.is_action_just_pressed("dash"):
	#	dash()
	
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and nbsauts == 0:
		velocity.y = JUMP_VELOCITY
		next_animation = "jump"
		nbsauts = 1
		
	# Gérer le double saut
	if Input.is_action_just_pressed("ui_accept") and not is_on_floor() and nbsauts < 2:
		velocity.y = JUMP_VELOCITY
		next_animation = "jump"
		nbsauts = 2
	
	# Réinitialiser le nombre de sauts
	if is_on_floor():
		nbsauts = 0
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if is_on_floor():
			next_animation = "run"
		else:
			next_animation = "jump"
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if next_animation != current_animation:
		changer_animation(next_animation)
		
	if is_on_floor() and not Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left") and not Input.is_action_just_pressed("ui_accept"):
		next_animation = "idle"
		
		
	# Gérer la direction de l'animation
	if (velocity.x >= 0):
		$AnimatedSpriteCountess.set_flip_h(false)
	# Sinon
	elif (velocity.x < 0):
		$AnimatedSpriteCountess.set_flip_h(true)

	move_and_slide()

"""
Fonction pour permettre au personnage de dash.
Consiste à seulement modifier la position du joueur selon sa direction.
"""
func dash():
	# Si le personnage regarde vers la droite
	if (velocity.x >= 0):
		position.x += DASH_VELOCITY
	# Sinon
	elif (velocity.x < 0):
		position.x -= DASH_VELOCITY
		
"""
Fonction pour changer l'animation du personnage.
@param animation : l'animation à utiliser
"""
func changer_animation(animation):
	$AnimatedSpriteCountess.play(animation)
	current_animation = animation 
	next_animation = ""
