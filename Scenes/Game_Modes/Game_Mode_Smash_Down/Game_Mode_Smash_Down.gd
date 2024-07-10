extends Node

@onready var lbl_Info = $UI/lbl_Timer
@onready var gg_Right_Score = $UI/Right_Score
@onready var gg_Left_Score = $UI/Left_Score

var gb_Smash_Side_Changed : bool = false
var gi_Smash_Start_Side : int = 0
var gb_Smashing : bool = false
var gg_Field : Node2D
var gi_Team_1_Score : int = 0
var gi_Team_2_Score : int = 0
var gf_Time_Since_Smash_Start : float = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	gg_Field = get_parent().get_node("Field") 
	var larr_Players = null
	while  larr_Players == null or len(larr_Players) == 0:
		larr_Players = get_tree().get_nodes_in_group("Player")
		await get_tree().create_timer(0.01).timeout
	
	print(larr_Players)
	for C1 in range(len(larr_Players)):
		larr_Players[C1].gg_Smash.connect(Player_Smash)

func Smashing():
	if not gb_Smashing:
		return
		
	if not gb_Smash_Side_Changed:
		gb_Smash_Side_Changed = gi_Smash_Start_Side != gg_Field.gg_Ball_Side
	
	if gb_Smash_Side_Changed:
		if gi_Smash_Start_Side == gg_Field.gg_Ball_Side:
			if gi_Smash_Start_Side == gg_Field.enum_Ball_Sides.LEFT:
				gi_Team_1_Score += 1
				Reset_Smash_Info()
			if gi_Smash_Start_Side == gg_Field.enum_Ball_Sides.RIGHT:
				gi_Team_2_Score += 1
				Reset_Smash_Info()
func Reset_Smash_Info():
	gb_Smashing = false
	gb_Smash_Side_Changed = false
	lbl_Info.text = ""
	
	
func Player_Smash(pp_Player):
	print("Smash Recieved")
	
	Reset_Smash_Info()
	gb_Smashing = true
	gf_Time_Since_Smash_Start = 0
	if pp_Player.global_position.x < 0:
		gi_Smash_Start_Side = gg_Field.enum_Ball_Sides.LEFT
		lbl_Info.text = "Left Smash"
	else:
		gi_Smash_Start_Side = gg_Field.enum_Ball_Sides.RIGHT
		lbl_Info.text = "Right Smash"
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	gg_Right_Score.text = "" + str(gi_Team_2_Score)
	gg_Left_Score.text = "" + str(gi_Team_1_Score)
	if gb_Smashing:
		gf_Time_Since_Smash_Start += delta
		if gf_Time_Since_Smash_Start > 5:
			Reset_Smash_Info()
	Smashing()
