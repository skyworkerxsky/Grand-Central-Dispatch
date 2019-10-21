import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

// MARK: First Group
let queue = DispatchQueue(label: "TurnOne", attributes: .concurrent) // создали очередь
let group = DispatchGroup() // создали группу

// Добавили в группу два куска кода
// Выполняем асинхронно
queue.async(group: group) {
    for i in 0...20 {
        if i == 14 {
            print(i)
        }
    }
}

queue.async(group: group) {
    for i in 0...20 {
        if i == 5 {
            print(i)
        }
    }
}

queue.async(group: group) {
    for i in 0...20 {
        if i == 10 {
            print(i)
        }
    }
}

group.notify(queue: .main) { // хотим чтобы уведомление пошло в main
    print("Код выполнен в группе - group")
}

// MARK: Second Group
let secondGroup = DispatchGroup()

secondGroup.enter() // Зашли в группу

queue.async(group: group) {
    for i in 0...30 {
        if i == 30 {
            print(i)
            //sleep(2)
            secondGroup.leave() // Вышли из группы
        }
    }
}

let result = secondGroup.wait(timeout: .now() + 1)

print(result)

secondGroup.notify(queue: .main) {
    print("Код выполнен в группе - secondGroup")
}

print("Этот принт будет выше чем последний")

// ждем выполнения определенного блока
secondGroup.wait() 
