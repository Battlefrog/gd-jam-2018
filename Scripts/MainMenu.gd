extends Control

func _ready():
	$options/explain.hide()
	
	$panel.hide()

func _on_PlayButton_pressed():
	$start/PlayButton.hide()
	$start/PlayButton.set_process(false)
	
	$start/OptionsButton.hide()
	$start/OptionsButton.set_process(false)
	
	$start/QuitGameButton.hide()
	$start/QuitGameButton.set_process(false)
	
	$story_explainer/RichTextLabel.show()
	$story_explainer/StartGameButton.show()
	
	$panel.show()

func _on_OptionsButton_pressed():
	$Label.set_text("Help")
	
	$start/PlayButton.hide()
	$start/PlayButton.set_process(false)
	
	$start/OptionsButton.hide()
	$start/OptionsButton.set_process(false)
	
	$start/QuitGameButton.hide()
	$start/QuitGameButton.set_process(false)
	
	$options/BackButton.show()
	$options/BackButton.set_process(true)
	
	$panel.show()

	$options/explain.show()

func _on_QuitGameButton_pressed():
	get_tree().quit()


func _on_BackButton_pressed():
	$Label.set_text("Going to Grandmas")
	
	$start/PlayButton.show()
	$start/PlayButton.set_process(true)
	
	$start/OptionsButton.show()
	$start/OptionsButton.set_process(true)
	
	$start/QuitGameButton.show()
	$start/QuitGameButton.set_process(true)
	
	$options/BackButton.hide()
	$options/BackButton.set_process(false)
	
	$options/explain.hide()
	$panel.hide()


func _on_StartGameButton_pressed():
	get_node("/root/global").goto_scene("res://Level1.tscn")
