extends Item

onready var sp = $AnimatedSprite

func _init_attrs():
    attr['planted'] = false
    attr['rose'] = false
    attr['grow_done'] = false
    
func _ready() -> void:
    sp.play("default")

func grow():
    attr['grow_done'] = true
    if attr['planted']  and attr['rose']:
        add_button("Rose", "res://Assets/SceneObjects/Items/rose.png", "玫瑰花")
        sp.play("grow_rose")
    elif attr['planted']  and !attr['rose']:
        add_button("SpringOnion", "res://Assets/SceneObjects/Items/springonion.png", "葱")
        print("get sprinonion")
        sp.play("grow_springonion")
        
        
func _update_attr(scene_objs):
    print("Flower Pot Updating")
    match scene_name:
        "Windowstill":
            print("hello Windowstill")
            if !attr['planted']:
                if scene_objs.has("SpringOnionSeed") and scene_objs["SpringOnionSeed"].get_anchor_name() == "SeedPos":
                    scene_objs["SpringOnionSeed"].plant()
                    attr['planted'] = true
                    attr['rose'] = false
                    print('planted')
                    sp.play("planted")
                elif scene_objs.has("RoseSeed") and scene_objs["RoseSeed"].get_anchor_name() == "SeedPos":
                    scene_objs["RoseSeed"].plant()
                    attr['planted'] = true
                    attr['rose'] = true
                    print('planted')
                    sp.play("planted")
    if !attr['grow_done'] and !attr["planted"]:
        sp.play("default")
             
