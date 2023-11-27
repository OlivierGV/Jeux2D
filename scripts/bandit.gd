extends CharacterBody2D

@onready var anim = $AnimatedSpriteBandit
@onready var AttenteDemiTour = $AttenteDemiTour
var estMort = false
var frappe = false
var versGauche = false
var enDeplacement = true
var enCombat = false
var pointVie = 20
var dommage = 10
var SPEED = 100.0
var cible = null
var current_animation = ""
var next_animation = ""
const JUMP_VELOCITY = -400.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


#Le bandit a 2 mode. Deplacement et Combat. Ils sont tous deux représentés par des variables bouléennes a vrai ou a faux.
func _physics_process(delta):
	velocity.y = gravity
	if estMort == false:
		if enDeplacement == true:
			deplacement()
		elif enDeplacement == false && AttenteDemiTour.is_stopped() && enCombat == false:
			demitour()
		else:
			velocity.x = 0
			next_animation = "idle"
			
		if enCombat == true:
			$AreaAttack/CollisionShapeAttack.disabled = true
			if $DelaiAttack.is_stopped():
				attaque()
			else:
				next_animation = "Run"
				velocity = position.direction_to(cible.position) * SPEED
				velocity.y = 0
				if not $DetectionTrou.is_colliding() and is_on_floor():
					velocity.x = 0
					next_animation = "idle"
					AttenteDemiTour.start()
				elif $DetectionObstacle.is_colliding() and is_on_floor():
					velocity.x = 0
					next_animation = "idle"
					AttenteDemiTour.start()
		if next_animation != current_animation:
			changer_animation(next_animation)
		move_and_slide()

func mort():
	anim.play("Death")
	$CollisionShapebandit.queue_free()
	estMort = true

func attaque():
	next_animation = "Attack"
	anim.play("Attack")
	$AreaAttack/CollisionShapeAttack.disabled = false


#fonction qui gère le déplacement hors mode combat
func deplacement():
	next_animation = "Run"
	if versGauche == true:
		velocity.x = Vector2.LEFT.x * SPEED 
		#velocity.x = direction* -SPEED
	else:
		velocity.x = Vector2.RIGHT.x * SPEED
	if not $DetectionTrou.is_colliding() and is_on_floor():
		enDeplacement = false
		AttenteDemiTour.start()
	elif $DetectionObstacle.is_colliding() and is_on_floor():
		enDeplacement = false
		AttenteDemiTour.start()

#le personnage fais demitour
func demitour():
	versGauche = !versGauche
	scale.x = -scale.x
	enDeplacement = true

#Fonction qui détecte le joueur dans son dos.
func _on_area_detection_body_entered(body):
	if body.is_in_group("joueur"):
		demitour()

#Gère si on entre en combat
func _on_area_detection_joueur_body_entered(body):
	if body.is_in_group("joueur"):
		cible = body
		enCombat = true
		enDeplacement = false

#Gère si on entre en mode déplacement.
func _on_area_detection_joueur_body_exited(body):
	if body.is_in_group("joueur"):
		cible = null
		enDeplacement = true
		enCombat = false

#Commence le délai après l'attaque.
func _on_animated_sprite_bandit_animation_finished():
	if anim.animation == "Attack":
		$AreaAttack/CollisionShapeAttack.disabled
		$DelaiAttack.start()
		next_animation = "idle"

func changer_animation(animation):
	anim.play(animation)
	current_animation = animation 
	next_animation = ""

#Fonction qui blesse la cible
func _on_area_attack_body_entered(body):
	if body.is_in_group("joueur"):
		body.blesse(dommage)

func blesse(degatrecu):
	next_animation="Hurt"
	pointVie -= degatrecu
	if pointVie <= 0:
		mort()
