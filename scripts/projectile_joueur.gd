extends CharacterBody2D


var speed = 300

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	var collision = move_and_collide(velocity.normalized() * delta * speed)
	if collision:
		# Si on a heurté un ennemi, indiquer à l'ennemi qu'il s'est fait heurté
		if collision.get_collider().name == 'Ennemi':
			collision.get_collider().perdrePoints()
		# Le projectile brise s'il y a une collision
		queue_free()
