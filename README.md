## SimpleStoryTeller
这是GGJ2024北京亦听站游戏 _LaguhStory_ 的源代码


### Contributors
- @vh_wz 实现了代码的整体框架, 设计并实现了部分关卡
- @gabriel 设计并实现了部分关卡
- @ZTY 设计并实现了部分关卡
- @火花骑士 设计并实现了部分关卡
- @uBGoat 设计并实现了烟花,2D光照,火焰等效果
- @oxox4312 绘制了关卡中的人物,道具和场景


### 如何运行
方法1：
在Release界面下载可执行文件

(但是现在还没导出所以暂时没有 :( )

方法2：使用Godot3.5编辑器运行

1.将源代码下载到本地

2.从云盘中下载Assets.zip，解压后放到项目根目录下, 文件夹结构如图所示
```bash
├─Assets # 素材文件
│  ├─Effects
│  │  └─Emojis
│  ├─Fonts
│  ├─SceneObjects
│  │  ├─Characters
│  │  └─Items
│  ├─Scenes
│  └─UI
├─AutoLoads # 自动加载脚本
├─Effects #效果 烟花，对话气泡等
├─Levels #关卡
├─SceneArea #场景区域
├─SceneObjects #场景中的物体
│  ├─Characters #人物
│  └─Items #道具
├─Scenes #场景
└─UI
```
3.在编辑器中导入项目，运行

### 重要的类

- `SceneAreaContainer`: 保存`SceneArea`和UI界面的容器, 一个 `SceneAreaContainer`实例就是一个关卡
- `SceneArea`: 划定了一个区域，用于存放`Scene`
- `Scene`: 场景类
- `Anchor`: 场景中的位置，用来放置`SceneObject`
- `SceneObject`:场景中的人物`Character`和道具`Item`的抽象类

### 如何新增关卡
1.新建一个`SceneAreaContainer`的继承场景,命名为`Level[关卡编号].tscn`,例如`Level1.tscn`

2.在关卡中添加场景区域`"SceneArea`,设置好区域的位置(目前只支持`600*330`的场景区域)

3.在`Scenes`文件夹下新建你需要的场景，新场景**必须继承**`Scene`

**Warning**:Bug多发地带：新建场景的文件名，根节点名字和属性中的`scene_name`必须相同

4.在`SceneObject/Characters`文件夹下新建你需要的人物，新人物**必须继承**`Character`

**Warning**:Bug多发地带：新建人物的文件名，根节点名字和属性中的`obj_name`必须相同

5.在`SceneObject/Items`文件夹下新建你需要的道具，新道具**必须继承**`Item`

**Warning**:Bug多发地带：新建道具的文件名，根节点名字和属性中的`obj_name`必须相同

7.在你新建的人物和场景根节点上点击**扩展脚本**,得到一个继承了父类的新脚本。

8.根据你的关卡设计，在新脚本中编写新人物和新道具的状态机

在`_init_attr()`中初始化你需要的属性(状态), 属性保存在一个字典`attr`中，例如
```
func _init_attr()：
    attr['health_status'] = 'good'
    attr["mood] = 'normal' 
    attr['have_extra_money'] = false
```
`attr`的`key`必须是字符串，并且由用下划线分割的小写字母组成。

`attr`的`value`可以是任何类型，建议使用字符串,枚举型或者布尔型。

在`_update_attr(scene_objects)`中设置属性的变化规则,例如
```
func _init_attr()：
    attr["mood] = 'normal' 

# scene_objects是一个字典，其中保存了当前场景中所有的SceneObject，格式
# {"obj_name":obj}, 其中obj是对象的引用
func _update_attr(scene_objects):
    match scene_name:
        "Bedroom"
            if scene_objs.has("SpringOnion") and scene_objs["SpringOnion"].get_anchor_name() == "FlowerPos" :
                set_mood("happy")
```

### NOTE:关于代码
- 在Godot的编辑器->编辑器设置->文本编辑器->缩进中，将缩进改为4个Spaces
- 场景`name.tscn`的文件名`name`必须和这个场景根节点的名称相同
- 场景名，节点名和类名每个单词的首字母大写(pascal命名法)， 例如`SceneObject`
- 函数和变量用小写单词下划线分割命名, 例如 `func check_game_finish() -> bool: `
- 名字必须有实际含义
- 图像等素材都放在`Assets`文件夹中


![](https://github.com/GKFXCode/SimpleStoryTeller/blob/master/Assets/Readme/classes.drawio.png)

![](../img/classes.drawio-1706007767746.png)


### THANKS

本项目的贡献者通过以下教程进行了学习:

@MateuSai 的项目 https://github.com/MateuSai/Godot-Roguelike-Tutorial/

@Game Development Center 制作的塔防游戏教程 _Make a Tower Defense Game in Godot_

