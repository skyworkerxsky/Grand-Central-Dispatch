import UIKit
import PlaygroundSupport

/*
Создание очередей:

Создание serial queue
DispatchQueue(label: "title")

Создание concurrent queue
DispatchQueue(label: "title", qos:.default, attributes: .concurrent)
 */

// Постоянно производим вычисления позволяя ассинхронному коду закончить вычисления
PlaygroundPage.current.needsIndefiniteExecution = true

class SafeArray<Element> {
    
    private var array = [Element]()
    private let queue = DispatchQueue(label: "DispatchBarrier", attributes: .concurrent) // создали очередь
    
    public func append(_ element: Element) {
        queue.async(flags: .barrier) { // пока выполняется барьер другая операция не начинается
            self.array.append(element)
        }
    }
    
    public var elements: [Element]{

        var result = [Element]()
        queue.sync {
            result = self.array
        }
        
        return result
    }
    
}

var safeArray = SafeArray<Int>()

// concurrentPerform - метод который позволяет выполнять параллельныe запросы
DispatchQueue.concurrentPerform(iterations: 10) { (index) in
    safeArray.append(index)
}
print ("safeArray: \(safeArray.elements)")

var array = [Int]()

// concurrentPerform - метод который позволяет выполнять параллельныe запросы
DispatchQueue.concurrentPerform(iterations: 10) { (index) in
    array.append(index)
}
print ("Array: \(array)")
