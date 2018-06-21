extends KinematicBody2D

signal player_hit_hole
signal player_used_match
signal player_got_wood
signal player_got_chocolate

export (int) var num_of_matches = 3

var got_wood = false
var got_chocolate = false

var player_up = preload("res://Sprites/player_up.png")
var player_down = preload("res://Sprites/player_down.png")
var player_left = preload("res://Sprites/player_left.png")
var player_right = preload("res://Sprites/player_right.png")

var velocity = Vector2()
var player_speed = 300

func _ready():
	$Sprite.set_texture(player_up)
	
	show()
	set_process(true)

func _process(delta):
	velocity = Vector2()
	
	# Detecting Movement
	if Input.is_action_pressed("ui_right"):
		$Sprite.set_texture(player_right)
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		$Sprite.set_texture(player_left)
		velocity.x -= 1
	if Input.is_action_pressed("ui_up"):
		$Sprite.set_texture(player_up)
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		$Sprite.set_texture(player_down)
		velocity.y += 1
	
	# Applying Movement
	var collision_info = move_and_collide(velocity.normalized() * player_speed * delta)
	
	CheckForCollisions(collision_info)
	
	position += velocity * delta

func CheckForCollisions(collisions):
	if collisions:
		#if collisions.collider.name.begins_with("wood_snow"):
			#if Input.is_action_pressed("ui_accept") and num_of_matches > 0:
				#collisions.collider.call("_on_player_hit")
				#$use_match.play()
				#num_of_matches -= 1
				#emit_signal("player_used_match", num_of_matches)
		pass
				
func hit_wood_snow():
	$use_match.play()
	lose_matches(1)

func gain_matches(matches_gained):
	num_of_matches += matches_gained
	emit_signal("player_used_match", num_of_matches)
	
func lose_matches(matches_lost):
	num_of_matches -= matches_lost
	emit_signal("player_used_match", num_of_matches)

func gain_matchbox():
	$grab_matchbox.play()
	gain_matches(1)
	
func get_wood():
	got_wood = true
	$grab_wood.play()
	emit_signal("player_got_wood")
	
func get_chocolate():
	got_chocolate = true
	$grab_matchbox.play()
	emit_signal("player_got_chocolate")
	
func got_wood():
	return got_wood
	
func got_chocolate():
	return got_chocolate
	
func return_match_count():
	return num_of_matches