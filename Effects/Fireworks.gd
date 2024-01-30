extends Particles2D

func set_color(color = "ff0000"):
    self.modulate = color
    
func set_speed(speed):
    speed_scale = speed
    
func start():
    emitting = true
    
func stop():
    emitting = false
    
        
