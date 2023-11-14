extends ColorRect
var item_selection = ""
var item_prix = 0
@onready var joueur = get_tree().get_nodes_in_group("Joueur")
@onready var liste = $ItemList_objets
# Dictionnaire des items pouvant être achetés
var objets_magasin = {
	"Flèche":{"peut_acheter":true, "icone":'res://icon.svg', "type":"Ammunition", "cout":10},
	"Couteau à lancer":{"peut_acheter":true, "icone":'res://icon.svg', "type":"Arme secondaire", "cout":25},
	"Eau bénite":{"peut_acheter":true, "icone":'res://icon.svg', "type":"Projectile", "cout":25},
	"Bombe paralysante":{"peut_acheter":true, "icone":'res://icon.svg', "type":"Projectile", "cout":25},
	"Cape":{"peut_acheter":true, "icone":'res://icon.svg', "type":"Armure", "cout":25}
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
	pass


"""
Il y a un bug avec ceci : https://github.com/godotengine/godot/issues/74086 . Le billet est fermé mais le bug reste. 
J'ai donc trouvé une solution en vérifiant que les items ne sont pas disabled.
"""
func _on_item_list_objets_item_selected(index):
	if not liste.is_item_disabled(index):
		item_selection = liste.get_item_text(index)
		item_prix = objets_magasin[item_selection]["cout"]
		print(item_selection)
		print(item_prix)

func _on_button_acheter_pressed():
	if item_selection != "" and joueur[0].argent > item_prix:
		print("achat")


func _on_button_2_quitter_pressed():
	get_tree().paused = false
	queue_free()
