extends Control

@onready var gg_Progress_Bar = $Panel/Progress_Bar


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	gg_Progress_Bar.value = Load_Manager.garr_Progress[0] * 100
