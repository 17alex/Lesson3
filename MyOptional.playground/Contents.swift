import Foundation

enum MyIntOptional {
    
    case none
    case some(Int)
    
    init(_ value: Int) {
        self = .some(value)
    }
    
    init() {
        self = .none
    }
    
}

postfix operator *!
postfix func *! (value: MyIntOptional) -> Int {
    switch value {
    case .some(let value):
        return value
    default:
        fatalError("unsafelyUnwrapped of nil optional")
    }
}

postfix operator *?
postfix func *? (value: MyIntOptional) -> MyIntOptional {
    return value
}

infix operator *??
func *?? (value: MyIntOptional, defaultValue: Int) -> Int {
    switch value {
    case .some(let intValue):
        return intValue
    default:
        return defaultValue
    }
}

extension MyIntOptional {
    func toStr() -> String {
        switch self {
        case .some(let intValue): return "Some(\(intValue))"
        default: return "MyNil"
        }
    }
}

var value1 = MyIntOptional(1) // some(1)
value1*?.toStr() // "Some(1)"

var value2 = MyIntOptional() // none
value2*?.toStr() // "MyNil"

var value3 = MyIntOptional(3) // some(3)
value3*! // 3

var value5 = value3 *?? 15 // 3

