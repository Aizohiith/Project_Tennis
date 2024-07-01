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
		print("Game Over")
		match gg_Field.gg_Ball_Side:
			gg_Field.enum_Ball_Sides.LEFT:
				print("Right Won")
			gg_Field.enum_Ball_Sides.RIGHT:
				print("Left Won")
			gg_Field.enum_Ball_Sides.LINE:
				print("Line: Draw")
			gg_Field.enum_Ball_Sides.OUT:
				print("OUT: Rematch")
		get_tree().paused = true
