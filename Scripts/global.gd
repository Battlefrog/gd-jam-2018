extends Node

var current_scene = null

func _ready():
	var root = get_tree().get_root()
	# Getting the current scene
	current_scene = root.get_child(root.get_child_count() - 1)
	
func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()

func goto_scene(path):
    # Deleting the current scene at this point might be
    # a bad idea, because it may be inside of a callback or function of it.
    # The worst case will be a crash or unexpected behavior.

    # The way around this is deferring the load to a later time, when
    # it is ensured that no code from the current scene is running:
    call_deferred("_deferred_goto_scene", path)

func _deferred_goto_scene(path):
	current_scene.free()

    # Load new scene
	var s = ResourceLoader.load(path)
	
	current_scene = s.instance()
	
	# Add it to the active scene, as child of root
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)