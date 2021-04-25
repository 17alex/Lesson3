class MyClass {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

struct MyContainer {
    private var myClass: MyClass
    
    var name: String {
        get { return myClass.name }
        set {
            guard isKnownUniquelyReferenced(&myClass) else {
                myClass = MyClass(name: newValue)
                return
            }
            myClass.name = newValue
        }
    }
    
    init(myClass: MyClass) {
        self.myClass = myClass
    }
}

let myClass1 = MyClass(name: "name1")

var myContainer1 = MyContainer(myClass: myClass1)
var myContainer2 = myContainer1

myContainer1.name
myContainer2.name

myContainer2.name = "name2"

myContainer1.name
myContainer2.name

myContainer1.name = "name3"

myContainer1.name
myContainer2.name
