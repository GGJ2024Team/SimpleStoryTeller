extends MyScene

var timer = Timer.new()
#var row = preload()
onready var rainSet = [$RainSet/Rain1, $RainSet/Rain2, $RainSet/Rain3, $RainSet/Rain4, $RainSet/Rain5]
var has_connect_performer = false

func _ready():
    connect("scene_updated",self,"on_scene_updated")


func on_scene_updated():
    if scene_objects.has("Performer"):
        connect_performer_sig()
    yield(get_tree().create_timer(2.0), "timeout")
    if scene_objects.has("Performer") and scene_objects.has("Audience"):
        if scene_objects["Performer"].attr["mood"] == "hesitate" and scene_objects["Audience"].attr["mood"] == "hesitate":
            pass #
 

func connect_performer_sig():   
    if has_connect_performer == false:
       has_connect_performer = true 
       scene_objects["Performer"].connect("start_rain",self,"on_start_rain")

func on_start_rain():
    for i in rainSet:
        i.start()
