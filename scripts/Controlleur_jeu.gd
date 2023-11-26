extends Node

@onready var cimettiere = preload('res://Scenes/mon_niveau_cimetiere.tscn').instantiate()
@onready var village = preload('res://Scenes/mon_niveau_village.tscn').instantiate()
@onready var niveau_actuel = village
@onready var joueur = get_tree().get_nodes_in_group("Joueur")
# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().root.add_child.call_deferred(village)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func changer_niveau(niveau):
	get_tree().root.remove_child(niveau_actuel)
	get_tree().root.add_child(niveau)
	niveau_actuel = niveau
	joueur[0].position = niveau.get_node("MarkerDepart").position
