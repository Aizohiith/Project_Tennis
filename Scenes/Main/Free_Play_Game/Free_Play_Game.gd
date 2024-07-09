extends Node2D

@onready var gg_Team_1 = $Team1
@onready var gg_Team_2 = $Team2

var gg_Ball_Scene = preload("res://Scenes/Ball/Ball.tscn")
var gg_Player_Scene = preload("res://Scenes/Player/Player.tscn")


var gi_Ball_Count : int = 0

var gi_Team_1_Count : int = 0
var gi_Team_2_Count : int = 0
var gb_Team_1_AI : bool = false
var gb_Team_2_AI : bool = false
# Called when the node enters the scene tree for the first time.

func _ready():
	for C1 in range(gi_Ball_Count):
		var T1 = gg_Ball_Scene.instantiate()
		T1.global_position = Vector2(0, 0)
		add_child(T1)
		
	for C1 in range(gi_Team_1_Count):
		var T1 = gg_Player_Scene.instantiate()
		T1.global_position = Vector2(-500, 0)
		gg_Team_1.add_child(T1)
		
	for C1 in range(gi_Team_2_Count):
		var T1 = gg_Player_Scene.instantiate()
		T1.global_position = Vector2(500, 0)
		gg_Team_2.add_child(T1)
		
	
	
	
	gg_Team_1.gb_AI = gb_Team_1_AI
	gg_Team_1.Setup()
	
	gg_Team_2.gb_AI = gb_Team_2_AI
	gg_Team_2.Setup()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
