extends Control

func _ready() -> void:
    for i in range(1, 6):
        var button = get_node("VBoxContainer/HBoxContainer/Level"+str(i))
        button.connect("pressed", self, "on_load_level", [i])
        
func on_load_level(i):
    GameData.current_level = i
    var level = load("res://Levels/Level"+str(i)+".tscn").instance()
    get_parent().add_child(level)
    queue_free()

