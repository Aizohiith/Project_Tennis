extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_quit_pressed():
	get_tree().quit()


func _on_skirmish_pressed():
	Load_Manager.Load_Scene_Instant("res://Scenes/Main/Free_Play/Free_Play.tscn")
