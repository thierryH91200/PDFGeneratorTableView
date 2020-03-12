//
//  Node.swift
//  Outline
//

import Foundation

@objcMembers
class Node: NSObject {
    var title = "Node"
    var isGroup = false
    var children = [Node]()
    weak var parent: Node?
    
    override init() {
        super.init()
    }
    
    init(title: String) {
        self.title = title
    }
    
    func isLeaf() -> Bool {
        return children.isEmpty
    }
}


class Others {
    var name = ""
    var things = ""
    
    init(name: String, things: String) {
        self.name = name
        self.things = things
    }
}

class Creatures {
    var type: String
    var other: [Others]
    
    init(type: String, other: [Others]) {
        self.type = type
        self.other = other
    }
}

@objcMembers class Person:NSObject {
    var givenName  = ""
    var familyName = ""
    var age        = ""
    
    class func createPerson(fName: String, lName: String, age: String)->Person {
        let person        = Person()
        person.givenName  = fName
        person.familyName = lName
        person.age        = age
        return person
        
    }
    
    func convertIntoDict() -> Dictionary<String, String> {
        var dict = Dictionary<String, String>()
        dict["givenName"] = self.givenName
        dict["familyName"] = self.familyName
        dict["age"] = self.age
        return dict
    }
}
