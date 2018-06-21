extends Area2D

onready var player = get_node("../Player")

func _ready():
	pass
	
func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		if self.overlaps_body(player):
			if player.call("return_match_count") > 0:
				player.call("hit_wood_snow")
				queue_free()