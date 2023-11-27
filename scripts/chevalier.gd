extends CharacterBody2D
@onready var anim = $ChevalierSprite
const SPEED = 70.0
var estmort = false
var attaque = false
var defend = false
var deplacement = false
var vientDeSeDeplacer = false
var gauche = true
var passif = true
var pv = 80
var dommage = 15
var current_animation = ""
var next_animation = ""

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func _ready():
	scale.x = -1

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	if estmort == false:
		if passif == true:
			next_animation = "idle"
			if $DelaiPassif.is_stopped():
				$DelaiPassif.start()
		if deplacement == true:
			next_animation = "walk"
			if $DureeMouvement.is_stopped():
				$DureeMouvement.start()
			if gauche == true:
				velocity.x = -1 * SPEED
			else:
				velocity.x = 1 * SPEED
		elif deplacement == false:
			velocity.x = 0
		if defend == true:
			next_animation = "protect"
			vientDeSeDeplacer = false
		if attaque == true:
			attaquer()
			vientDeSeDeplacer = false
		if defend == true:
			velocity.x = 0
			if $DureeDefense.is_stopped():
				$DureeDefense.start()
		if next_animation != current_animation:
			changer_animation(next_animation)

	move_and_slide()

func changer_animation(animation):
	anim.play(animation)
	current_animation = animation 
	next_animation = ""
	
func perdrePoints(dommage):
	if defend == true:
		anim.play("defend")
		$DureeDefense.stop()
		$DureeDefense.start()
	else:
		next_animation = "blesse"
		pv -= dommage
		if pv <= 0:
			mort()
		else:
			attaque = false
			defend = true
			deplacement = false
			passif = false
func mort():
	anim.play("mort")
	estmort = true
	$chevalierHitBox.queue_free()
	gravity = 0


func _on_duree_mouvement_timeout():
	$DureeMouvement.stop()
	deplacement = false
	gauche = !gauche
	vientDeSeDeplacer = true
	passif = true


func _on_delai_passif_timeout():
	passif = false
	$DelaiPassif.stop()
	if vientDeSeDeplacer == false:
		deplacement = true
	else:
		attaque = true

func attaquer():
	next_animation = "attack"
	$AreaAttack/CollisionShapeAttack.disabled = false


func _on_chevalier_sprite_animation_finished():
	if anim.animation == "attack":
		$AreaAttack/CollisionShapeAttack.disabled = true
		attaque = false
		passif = true


func _on_detectiondos_body_entered(body):
	if body.is_in_group("joueur"):
		scale.x = -scale.x


func _on_duree_defense_timeout():
	$DureeDefense.stop()
	deplacement = false
	velocity.x = 0
	vientDeSeDeplacer = false
	passif = false
	defend = false
	attaque = true


func _on_area_attack_body_entered(body):
	if body.has_method("perdrePoints"):
		body.perdrePoints(dommage)

