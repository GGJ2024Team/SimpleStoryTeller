extends Node2D


onready var rain = get_node("DumplingRain")


# Called when the node enters the scene tree for the first time.
func _ready():
    rain.stop()

func start():
    rain.start()
