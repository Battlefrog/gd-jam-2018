extends Control

signal go_burn_house
signal go_set_up_camp

onready var player = get_parent().get_parent().get_parent()
onready var hole = get_node("/root/hole")

export (String) var next_level_name

var image_wood = preload("res://Sprites/wood.png")
var image_chocolate = preload("res://Sprites/chocolate.png")
var image_supplies = preload("res://Sprites/supplies.png")

var match_got = false
var game_end = false

func _ready():
	$popup.hide()
	$black.hide()
	$black/end.hide()
	$black/credits.hide()
	
	player.connect("player_used_match", self, "update_match_display")
	player.connect("player_got_wood", self, "player_got_wood")
	player.connect("player_got_chocolate", self, "player_got_chocolate")
	
	update_match_display(3)

func update_match_display(match_num):
	$Inventory/matches/MatchDisplay.set_text(str(match_num))
	
func player_got_wood():
	$Inventory/slot.set_texture(image_wood)
	$Inventory/slot.set_tooltip("Wood for grandma's furnace.")
	$Inventory/slot.show()
	
func player_got_chocolate():
	$Inventory/slot.set_texture(image_chocolate)
	$Inventory/slot.set_tooltip("Chocolate for cookies.")
	$Inventory/slot.show()
	
func player_got_supplies():
	$Inventory/slot.set_texture(image_supplies)
	$Inventory/slot.set_tooltip("Supplies for a campsite.")
	
func player_used_supplies():
	$Inventory/slot.hide()
	
func display_get_wood():
	$popup.popup()
	
	player.set_process(false)
	
func display_burn_house():
	if !match_got:
		$popup.popup()
	
		emit_signal("go_burn_house")
	
		$Inventory/slot.hide()
	
		$popup/Header.set_text("Grandma makes an odd request!")
		$popup/Text.set_text("Okay, so grandma needs you to use a match on her neighbor's house for her.\nApparently no one lives there anymore, and it'll warm the place up. Seems okay?\nOh, and grandma gave you 2 matches! Now nice of her...")
	
		player.gain_matches(2)
		player.set_process(false)
		
		match_got = true
	else:
		$popup.popup()
		
		$Inventory/slot.hide()
	
		$popup/Header.set_text("Grandma makes an odd request!")
		$popup/Text.set_text("Okay, so grandma needs you to use a match on her neighbor's house for her.\nApparently no one lives there anymore, and it'll warm the place up. Seems okay?")
		
		player.set_process(false)
	
	
func display_get_chocolate():
	$popup.popup()
	
	$Inventory/slot.hide()
	
	$popup/Header.set_text("Grandma needs chocolate!")
	$popup/Text.set_text("With the pathway to the lake clear, there are only a couple more tasks needed to make cookies!\nGrandma needs some wild chocolate for her secret recipe. It's normally growing near the lake.")

	player.set_process(false)
	
func display_set_up_camp():
	$popup.popup()
	
	$Inventory/slot.set_texture(image_supplies)
	
	$popup/Header.set_text("Grandma needs help with setting up camp!")
	$popup/Text.set_text("After getting the chocolate, Grandma is busy cooking the cookies.\nWhy don't you setup camp for your dear old Grandma? There's a nice rock with a view of the lake.\nGo set it up there.")
	
	emit_signal("go_set_up_camp")
	
	player.set_process(false)
	
func display_ending():
	$popup.popup()
	
	$popup/Header.set_text("Grandma's nearly done with the cookies!")
	$popup/Text.set_text("With the camp setup, it's only a matter of time before the cookies are done.\nIn the mean time, relax inside (Where it's quite warm) and have quality time with your grandma.")
	
	player.set_process(false)
	
	game_end = true

func _on_popup_hide():
	if !game_end:
		# Let the Player move
		player.set_process(true)
		pass
	else:
		get_node("/root/global").goto_scene("res://Credits.tscn")
