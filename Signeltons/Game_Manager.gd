extends Node

signal gg_Screen_Shake

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func Generate_Random_2D_Vector():
	var lf_X = randf_range(-1.0, 1.0)
	var lf_Y = randf_range(-1.0, 1.0)
	return Vector2(lf_X, lf_Y)
	
func Generate_Normal_Distributed_Float(lf_Mean: float = 0.0, lf_STD: float = 1.0) -> float:
	var lf_U1 = randf()
	var lf_U2 = randf()
	var lf_Z = sqrt(-2.0 * log(lf_U1)) * cos(2.0 * PI * lf_U2)
	return lf_Z * lf_STD + lf_Mean
