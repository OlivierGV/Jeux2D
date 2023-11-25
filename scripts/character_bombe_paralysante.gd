extends CharacterBody2D


const SPEED = 300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

"""
Pour que ça marche, tous les ennemis doivent appartenir à un groupe nommé "ennemi" et avoir une 
méthode nommée perdrePoints qui a la quantité de PV à perdre en paramètre

À FINIR
"""
func _physics_process(delta):
	var collision = move_and_collide(velocity.normalized() * delta * SPEED)
	
	#if position.x - $CharacterCountess.position.x > 400:
	#	retourner()
	if collision:
		for bodies in $AreaBombe.get_overlapping_bodies():
			if bodies.is_in_group("ennemi"):
				print("eau ouch")
				#bodies.call("perdrePoints", 40)
		queue_free()
