extends Node
# DataStructure

class Set:
    var data = {}
    func add(item):
        data[item] = null
    func erase(item):
        data.erase(item)
    func has(item):
        return data.has(item)
    func _to_string() -> String:
        var s = "{"
        for k in data:
            s += k + ', '
        s += '}'
        return s
        
#class DLinkListNode:
#    var item = null
#    var next:DLinkListNode = null
#    var prev:DLinkListNode = null
#
#    func _to_string() -> String:
#        return "DLinkListNode"
#
#class DLinkList:
#    var dummy_head = DLinkListNode.new()
#    var dummy_tail = DLinkListNode.new()
#    var length = 0
#
#    func _init() -> void:
#        dummy_head.next = dummy_tail
#        dummy_tail.prev = dummy_head
#
#    func is_empty() -> bool:
#        return length == 0
#
#    func length() -> int:
#        return length
#
#    func push_back(item):
#        var new_node = DLinkListNode.new()
#        new_node.item = item
#        new_node.next = dummy_tail
#        new_node.prev = dummy_tail.prev
#        dummy_head.prev.next = new_node
#        dummy_head.prev = new_node
#        length += 1
#
#    func push_front(item):
#        var new_node = DLinkListNode.new()
#        new_node.item = item
#        new_node.prev = dummy_head
#        new_node.next = dummy_head.next
#        dummy_head.next.prev = new_node
#        dummy_head.next = new_node
#        length += 1
#
#    func _to_string() -> String:
#        return "DLinkList"
