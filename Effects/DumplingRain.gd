extends Node2D



onready var particles2d: Particles2D = get_node("Particles2D")


func set_speed(speed):
    particles2d.speed_scale = speed
    
func start():
    particles2d.emitting = true
    
func stop():
    particles2d.emitting = false

