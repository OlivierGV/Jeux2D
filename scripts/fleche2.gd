extends Area2D

var velocity = 0
var SPEED = 600
var dommage = 20
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity * delta


func _on_body_entered(body):
	if body.has_method("perdrePoints"):
		body.perdrePoints(dommage)
	self.queue_free()

func start(_position, _direction):
	rotation = _direction
	position = _position
	velocity = Vector2(SPEED, 0).rotated(rotation)
