extends Control

@onready var gg_Help = $Help

# Called when the node enters the scene tree for the first time.
func _ready():
	gg_Help.hide()
	Game_Manager.Set_Achievement("GS")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_quit_pressed():
	get_tree().quit()


func _on_skirmish_pressed():
	Load_Manager.Load_Scene_Instant("res://Scenes/Main/Free_Play/Free_Play.tscn")


func _on_settings_pressed():
	Load_Manager.Load_Scene_Instant("res://Scenes/Main/Settings/Settings.tscn")


func _on_help_pressed():
	gg_Help.show()


func _on_help_close_requested():
	gg_Help.hide()
