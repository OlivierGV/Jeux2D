extends ColorRect
var item_selection = ""
var id_item_selection = 0
var item_prix = 0
@onready var joueur = get_tree().get_nodes_in_group("Joueur")
@onready var liste = $ItemList_objets
# Dictionnaire des items pouvant être achetés
var objets_magasin = {
	"Flèche":{"peut_acheter":30, "icone":'res://Assets/ArmesSecondaires/iconefleche.png', "type":"Ammunition", "cout":10},
	"Eau bénite":{"peut_acheter":10, "icone":'res://Assets/ArmesSecondaires/iconeeau.png', "type":"Projectile", "cout":25},
	"Bombe paralysante":{"peut_acheter":10, "icone":'res://Assets/ArmesSecondaires/iconebombe.png', "type":"Projectile", "cout":25},
	"Cape":{"peut_acheter":1, "icone":'res://Assets/ArmesSecondaires/cloth_hood.png', "type":"Armure", "cout":25}
}

# Called when the node enters the scene tree for the first time.
func _ready():
	#Définir l'argent
	$RichTextLabel_argent.text = "Argent : " +  str(joueur[0].argent)
	#Ajouter les objets au magasin
	for objet in objets_magasin:
		var icone = load(objets_magasin[objet]["icone"])
		liste.add_item(objet, icone, objets_magasin[objet]["peut_acheter"])
		liste.add_item(objets_magasin[objet]["type"], null, false)
		liste.set_item_disabled(liste.get_item_count() - 1, true)
		liste.add_item(str(objets_magasin[objet]["cout"]), null, false)
		liste.set_item_disabled(liste.get_item_count() - 1, true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$RichTextLabel_argent.text = "Argent : " +  str(joueur[0].argent)


"""
Il y a un bug avec ceci : https://github.com/godotengine/godot/issues/74086 . Le billet est fermé mais le bug reste. 
J'ai donc trouvé une solution en vérifiant que les items ne sont pas disabled.
"""
func _on_item_list_objets_item_selected(index):
	if not liste.is_item_disabled(index):
		id_item_selection = index
		item_selection = liste.get_item_text(index)
		item_prix = objets_magasin[item_selection]["cout"]
		print(item_selection)
		print(item_prix)

func _on_button_acheter_pressed():
	if item_selection != "" and joueur[0].argent >= item_prix:
		var nb_de_item = joueur[0].inventaire[item_selection]["quantite"]
		joueur[0].argent -= item_prix
		joueur[0].inventaire[item_selection]["quantite"] = nb_de_item + 1
		objets_magasin[item_selection]["peut_acheter"] -= 1
		if (objets_magasin[item_selection]["peut_acheter"] <= 0):
			liste.set_item_disabled(id_item_selection, true)
			item_selection = ""
	


func _on_button_2_quitter_pressed():
	get_tree().paused = false
	queue_free()
