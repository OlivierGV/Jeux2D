extends CharacterBody2D


const SPEED = 100
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var joueur = $"../CharacterCountess"
var animation_boss = 0
var test = 0

func _ready():
	$AnimatedSprite2D.play("transform")
	$TimerTransformation.start()

func _physics_process(delta):
	#Sa transformation
	if(animation_boss == 0):
		velocity.y = 0
		position = Vector2(569, 580)
	#Sa phase de chasse
	if(animation_boss == 1):
		$AnimatedSprite2D.play("boss_walk")
		var velocity = global_position.direction_to(joueur.global_position)
		move_and_collide(velocity * SPEED * delta)
		if($TimerAttaque.is_stopped()):
			$TimerAttaque.start()
	#Pause pendant l'attaque
	if(animation_boss == 2):
		velocity = Vector2(0,0)
		if($TimerTransformation.is_stopped()):
			$TimerTransformation.start()
	#Moment d'inactivité
	if(animation_boss == 3):
		move_and_collide(Vector2(0, 1)) 
		if($TimerStunned.is_stopped()):
			$TimerStunned.start()
			
	#Vérifier les hitboxes
	if(animation_boss == 3):
		$CollisionShape2D.disabled = false
	if(animation_boss != 3):
		$CollisionShape2D.disabled = true
		
func _on_timer_transformation_timeout():
	if(animation_boss == 0):
		animation_boss = 1
	#Après l'attaque
	if(animation_boss == 2):
	#Le boss est en fatigue, le joueur doit l'attaquer
		animation_boss = 3
		#position.y = 580


func _on_timer_attaque_timeout():
	if($AnimatedSprite2D.is_playing()):
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.play("boss_attack")
		animation_boss = 2


func _on_timer_stunned_timeout():
	animation_boss = 1
