extends Area2D

# Il faut trouver une meilleure façon de décider du prochain niveau
var chemin = "$Area2D.metadata/cheminProchainNiveau"
var prochain_niveau = "preload(chemin).instantiate()"
@onready var controlleur = get_tree().root.get_node('Main/Controlleur_jeu')
@onready var joueur = get_tree().get_nodes_in_group("Joueur")
# Called when the node enters the scene tree for the first time.
func _ready():
	var chemin = get_meta('cheminProchainNiveau')
	prochain_niveau = load(chemin).instantiate()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

"""
Pour déclarer le prochain niveau, il faut placer cette scène dans chaque scène de niveau et 
"""
func _on_body_entered(body):
	if body == joueur[0]:
		controlleur.changer_niveau(prochain_niveau)
