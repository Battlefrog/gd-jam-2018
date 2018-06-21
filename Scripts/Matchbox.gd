extends Area2D

func _ready():
	pass

func _on_Matchbox_body_entered(body):
	print(body.get_name())
	if body.is_in_group("Player"):
		body.call("gain_matchbox")
		queue_free()
