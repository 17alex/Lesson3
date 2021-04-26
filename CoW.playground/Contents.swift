import Foundation

class MyClass {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

struct MyStruct {
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
    
    init(name: String) {
        self.myClass = MyClass(name: name)
    }
    
    func printName() {
        print(Unmanaged.passUnretained(myClass).toOpaque(), " - \(myClass.name)")
    }
}

var myStruct1 = MyStruct(name: "name1")
var myStruct2 = myStruct1
var myStruct3 = myStruct2

myStruct1.printName() //0x00006000033bc140  - name1
myStruct2.printName() //0x00006000033bc140  - name1
myStruct3.printName() //0x00006000033bc140  - name1

print("\n")

myStruct2.name = "name2"
myStruct1.printName() //0x00006000033bc140  - name1
myStruct2.printName() //0x00006000033bcd20  - name2
myStruct3.printName() //0x00006000033bc140  - name1

print("\n")

myStruct1.name = "name3"
myStruct1.printName() //0x00006000033bce40  - name3
myStruct2.printName() //0x00006000033bcd20  - name2
myStruct3.printName() //0x00006000033bc140  - name1

print("\n")

myStruct1.name = "name4"
myStruct1.printName() //0x00006000033bce40  - name4
myStruct2.printName() //0x00006000033bcd20  - name2
myStruct3.printName() //0x00006000033bc140  - name1
