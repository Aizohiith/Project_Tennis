extends Sprite2D

@export var gi_Max_Track : int = 5
var garr_Positions = []
var gg_Target : Node2D
# Called when the node enters the scene tree for the first time.
func _ready():
	gg_Target = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var lv2_Next_Pos = gg_Target.global_position
	garr_Positions.append(lv2_Next_Pos)
	if (len(garr_Positions) > gi_Max_Track):
		var T1 = garr_Positions.pop_front()
		global_position = lerp(global_position, T1, 0.5)
