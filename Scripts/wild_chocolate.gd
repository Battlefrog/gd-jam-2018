extends Area2D

func _ready():
	self.set_visible(false)
	self.set_process(false)

func _on_wild_chocolate_body_entered(body):
	if (self.is_visible()):
		if body.is_in_group("Player"):
			body.call("get_chocolate")
			queue_free()