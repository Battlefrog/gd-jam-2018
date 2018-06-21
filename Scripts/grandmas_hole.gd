extends Area2D

signal player_returned_wood

var collected_wood = false
var made_camp = false

onready var house = get_node("../NeighborHouse")
onready var rock = get_node("../rock")
onready var GameUI = get_node("../Player").get_node("Camera2D").get_node("CanvasLayer").get_node("GameUI")

func _ready():
	rock.connect("campfire_placed", self, "campfire_placed")
	
	$CollisionShape2D.set_disabled(false)

func _on_hole_body_entered(body):
	print(body.get_name())
	if body.is_in_group("Player"):
		$player_visits.play()
		if not body.call("got_wood"):
			GameUI.call("display_get_wood")
			get_node("../WoodPile").show()
			get_node("../WoodPile").set_process(true)
			collected_wood = true
		elif body.call("got_wood") and collected_wood and house.has_burned() and body.got_chocolate() and made_camp:
			GameUI.call("display_ending")
		elif body.call("got_wood") and collected_wood and house.has_burned() and body.got_chocolate():
			GameUI.call("display_set_up_camp")
		elif body.call("got_wood") and collected_wood and house.has_burned():
			GameUI.call("display_get_chocolate")
			get_node("../wild_chocolate").show()
			get_node("../wild_chocolate").set_process(true)
		elif body.call("got_wood") and collected_wood:
			GameUI.call("display_burn_house")
			emit_signal("player_returned_wood")
		
func campfire_placed():
	made_camp = true