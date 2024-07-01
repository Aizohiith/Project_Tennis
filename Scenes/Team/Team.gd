extends Node2D

var lf_Team_Color : float = 0.5


# Called when the node enters the scene tree for the first time.
func _ready():
	lf_Team_Color = randf()
	var larr_Childer = get_children()
	for C1 in range(len(larr_Childer)):
		larr_Childer[C1].Set_Color(lf_Team_Color)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
