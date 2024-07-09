extends Node

@export var gf_Max_Swap_Time = 5
@onready var lbl_Timer = $UI/lbl_Timer
@onready var gg_Right_Score = $UI/Right_Score
@onready var gg_Left_Score = $UI/Left_Score

var gf_Time_Since_Swap : float = 0
var gg_Field : Node2D
var gg_Pre_Ball_Side : int = 0
var gi_Team_1_Score : int = 0
var gi_Team_2_Score : int = 0
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
	gg_Right_Score.text = "" + str(gi_Team_2_Score)
	gg_Left_Score.text = "" + str(gi_Team_1_Score)
	if gf_Max_Swap_Time - gf_Time_Since_Swap <= 0:
		lbl_Timer.text = "Game Over\n"
		match gg_Field.gg_Ball_Side:
			gg_Field.enum_Ball_Sides.LEFT:
				lbl_Timer.text += "Right Won\n"
				gi_Team_2_Score += 1
			gg_Field.enum_Ball_Sides.RIGHT:
				lbl_Timer.text += "Left Won\n"
				gi_Team_1_Score += 1
			gg_Field.enum_Ball_Sides.LINE:
				lbl_Timer.text += "Line: Draw\n"
				gi_Team_1_Score += 1
				gi_Team_2_Score += 1
			gg_Field.enum_Ball_Sides.OUT:
				lbl_Timer.text += "Out: Rematch\n"
		get_tree().paused = true
		if gi_Team_1_Score == 5 and gi_Team_2_Score == 0:
			Game_Manager.Set_Achievement("5/0")
		await get_tree().create_timer(1.5).timeout
		get_tree().paused = false
		Reset()


func Reset():
	gf_Time_Since_Swap = 0
	gg_Pre_Ball_Side = 0
	gg_Field.Reset()
	
	var larr_Balls = get_tree().get_nodes_in_group("Ball")
	for C1 in range(len(larr_Balls)):
		larr_Balls[C1].freeze = true
		
	var larr_Players = get_tree().get_nodes_in_group("Player")
	for C1 in range(len(larr_Players)):
		larr_Players[C1].freeze = true
		larr_Players[C1].Reset()
