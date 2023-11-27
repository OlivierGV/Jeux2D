extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func bossMort():
	$StaticBodyPorteSortie.queue_free()


func _on_area_trou_body_entered(body):
	body.mort()


func _on_area_etang_body_entered(body):
	body.SPEED = body.SPEED/4


func _on_area_etang_body_exited(body):
	body.SPEED = body.SPEED *4


func _on_area_etang_2_body_entered(body):
	body.SPEED = body.SPEED/4


func _on_area_etang_2_body_exited(body):
	body.SPEED = body.SPEED *4


func _on_area_etang_3_body_entered(body):
	body.SPEED = body.SPEED/4


func _on_area_etang_3_body_exited(body):
	body.SPEED = body.SPEED *4


func _on_area_etang_4_body_entered(body):
	body.SPEED = body.SPEED/4


func _on_area_etang_4_body_exited(body):
	body.SPEED = body.SPEED*4


func _on_area_etang_5_body_entered(body):
	body.SPEED = body.SPEED/4


func _on_area_etang_5_body_exited(body):
	body.SPEED = body.SPEED*4


func _on_area_etang_6_body_entered(body):
	body.SPEED = body.SPEED/4


func _on_area_etang_6_body_exited(body):
	body.SPEED = body.SPEED*4
