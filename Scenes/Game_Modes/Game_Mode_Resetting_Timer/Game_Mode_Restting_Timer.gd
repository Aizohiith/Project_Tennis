extends Node

@export var gf_Max_Swap_Time = 5
@onready var lbl_Timer = $UI/lbl_Timer
var gf_Time_Since_Swap : float = 0
var gg_Field : Node2D
var gg_Pre_Ball_Side : int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	gg_Field = get_parent().get_node("Field") 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	gf_Time_Since_Swap += delta
	if (gg_Pre_Ball_Side != gg_Field.gg_Ball_Side):
		gf_Time_Since_Swap = 0
		gg_Pre_Ball_Side = gg_Field.gg_Ball_Side

	lbl_Timer.text = str(round(10 * (gf_Max_Swap_Time - gf_Time_Since_Swap)) / 10)
	if gf_Max_Swap_Time - gf_Time_Since_Swap <= 0:
		lbl_Timer.text = "Game Over\n"
		match gg_Field.gg_Ball_Side:
			gg_Field.enum_Ball_Sides.LEFT:
				lbl_Timer.text += "Right Won\n"
			gg_Field.enum_Ball_Sides.RIGHT:
				lbl_Timer.text += "Left Won\n"
			gg_Field.enum_Ball_Sides.LINE:
				lbl_Timer.text += "Line: Draw\n"
			gg_Field.enum_Ball_Sides.OUT:
				lbl_Timer.text += "Out: Rematch\n"
		get_tree().paused = true
		await get_tree().create_timer(1.5).timeout
		get_tree().paused = false
		Load_Manager.Load_Scene("res://Scenes/Test/Test.tscn")
