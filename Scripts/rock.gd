extends Area2D

signal campfire_placed

var campsite_allowed = false

onready var GameUI = get_node("../Player").get_node("Camera2D").get_node("CanvasLayer").get_node("GameUI")

func _ready():
	GameUI.connect("go_set_up_camp", self, "go_set_up_camp")
	
	$with_camp.hide()

func _on_rock_body_entered(body):
	if body.is_in_group("Player") and campsite_allowed:
			emit_signal("campfire_placed")
			$normal.hide()
			$with_camp.show()
			GameUI.player_used_supplies()
			$put_camp_on.play()

func go_set_up_camp():
	campsite_allowed = true