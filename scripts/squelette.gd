extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var pv = 40
var cac = false
var estmort = false
@onready var fleche = preload("res://scenes/fleche.tscn")
var dommage = 12
@onready var anim = $"squelette-sprite"
var current_animation = ""
var next_animation = ""
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")



func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	if estmort == false:
		if cac == false && $DelaiTir.is_stopped():
			next_animation="shot"
		elif cac == true &&$DelaiDague.is_stopped():
			frapper()
		else:
			next_animation="idle"
		if next_animation != current_animation:
			changer_animation(next_animation)
	move_and_slide()

func tirer():
	var f = fleche.instantiate()
	f.start($apparitionfleche.global_position, self.global_rotation)
	f.transform = $apparitionfleche.global_transform
	get_tree().root.add_child(f)
	$DelaiTir.start()
	next_animation = "idle"

func frapper():
	next_animation = "attack"
	anim.play("attack")
	$AreaAttack/CollisionShapeAttack.disabled = false

func changer_animation(animation):
	anim.play(animation)
	current_animation = animation 
	next_animation = ""


func _on_squelettesprite_animation_finished():
	if anim.animation == "attack":
		$AreaAttack/CollisionShapeAttack.disabled
		$DelaiDague.start()
		next_animation = "idle"
	elif anim.animation == "shot":
		tirer()
		

func _on_area_attack_body_entered(body):
	if body.is_in_group("joueur"):
		body.perdrePoints(dommage)


func _on_zone_ca_c_body_entered(body):
	if body.is_in_group("joueur"):
		cac = true


func _on_zone_ca_c_body_exited(body):
	if body.is_in_group("joueur"):
		cac = false


func _on_zonedetectiondos_body_entered(body):
	if body.is_in_group("joueur"):
		scale.x = -scale.x

func perdrePoints(dommage):
	pv = pv - dommage
	next_animation="hurt"
	if pv <= 0:
		mort()

func mort():
	anim.play("dead")
	estmort=true
	$"squelette-collision".queue_free()
	


