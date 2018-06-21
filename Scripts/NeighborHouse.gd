extends Area2D

signal player_burned_house

onready var GameUI = get_node("../Player").get_node("Camera2D").get_node("CanvasLayer").get_node("GameUI")
onready var player = get_node("../Player")

var player_allowed_to_burn = false
var burned = false

func _ready():
	GameUI.connect("go_burn_house", self, "go_burn_house")
	
	$StaticBody2D/after_fire1.set_disabled(true)
	$StaticBody2D/after_fire2.set_disabled(true)

func _on_NeighborHouse_body_entered(body):
	if (player_allowed_to_burn):
			print(body.get_name())
			if player.return_match_count() > 0 and !burned:
				player.lose_matches(1)
				player.set_process(false)
				$fire.play()
				GameUI.get_node("Inventory").get_node("matches").get_node("texture").hide()
				GameUI.get_node("Inventory").get_node("matches").get_node("MatchDisplay").hide()
				GameUI.get_node("black").show()
				yield(get_tree().create_timer(5.00), "timeout")
				$Normal.hide()
				$Burned.show()
				$StaticBody2D/before_fire.set_disabled(true)
				$StaticBody2D/after_fire1.set_disabled(false)
				$StaticBody2D/after_fire2.set_disabled(false)
				GameUI.get_node("black").hide()
				GameUI.get_node("Inventory").get_node("matches").get_node("texture").show()
				GameUI.get_node("Inventory").get_node("matches").get_node("MatchDisplay").show()
				player.set_process(true)
				emit_signal("player_burned_house")
				burned = true

func go_burn_house():
	player_allowed_to_burn = true
	print(player_allowed_to_burn)
	
func has_burned():
	return burned