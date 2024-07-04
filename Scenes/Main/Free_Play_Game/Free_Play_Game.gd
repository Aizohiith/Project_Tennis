extends Node2D

var gg_Ball_Scene = preload("res://Scenes/Ball/Ball.tscn")
var gi_Ball_Count : int = 1
# Called when the node enters the scene tree for the first time.

func _ready():
	for C1 in range(gi_Ball_Count):
		var T1 = gg_Ball_Scene.instantiate()
		T1.global_position = Vector2(100, 100)
		add_child(T1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
