extends SceneObject
class_name Character


func _init() -> void:
    attr["mood"] = "normal"

func set_mood(new_mood, vis=true, vis_pos=null):
    print("set mood : ", new_mood)
    attr["mood"] = new_mood
    on_mood_update(attr["mood"], new_mood)
    if vis:
        var bubble = Bubble.instance()
        bubble.emoji_path = GameData.mood_emojis[attr["mood"]]
        bubble.bubble_last_sec = 2
        if vis_pos != null:
            bubble.position = vis_pos
        add_child(bubble)
        

func show_mood(mood):
    pass
    
func on_mood_update(old_mood, new_mood):
    pass
    
func get_mood() -> String:
    return attr["mood"]
