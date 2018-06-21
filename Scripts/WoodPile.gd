extends Area2D

func _ready():
	self.set_visible(false)
	self.set_process(false)

func _on_WoodPile_body_entered(body):
	if (self.is_visible()):
		if body.is_in_group("Player"):
			body.call("get_wood")
			queue_free()
