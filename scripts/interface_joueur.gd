extends GridContainer
@onready var joueur = get_tree().get_nodes_in_group("Joueur")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$RichTextLabel_pv.text = "Vie : " + str(joueur[0].hp) + "/100"
	$RichTextLabel_argent.text = "Argent : " + str(joueur[0].argent)
