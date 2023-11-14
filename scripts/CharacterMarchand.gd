extends CharacterBody2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var sceneMagasin = preload('res://Scenes/menu_magasin.tscn')
var menu_ouvert = false
"""
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
"""

func _on_area_2d_marchand_body_entered(body):
	if not menu_ouvert:
		print("dwa")
		var menu_magasin = sceneMagasin.instantiate()
		get_tree().root.add_child(menu_magasin)
		get_tree().paused = true
		menu_ouvert = true

"""jsp si nécessaire"""
func _on_area_2d_marchand_body_exited(body):
	menu_ouvert = false
