import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

// создаем блок
let workItem = DispatchWorkItem(qos: .utility, flags: .detached) {
    print("Выполняем - workItem")
}

// Выпоняем workItem
//workItem.perform()

// autoreleaseFrequency - настройка для управления памятью
// target - нужен для того чтобы переназначить очередь для объекта
let queue = DispatchQueue(label: "turnOne", qos: .utility, attributes: .concurrent, autoreleaseFrequency: .workItem, target: DispatchQueue.global(qos: .userInitiated))

// Вызвали асинхронно
queue.asyncAfter(deadline: .now() + 1, execute: workItem)

// Сделали уведомление по завершению блока workitem в главном потоке
workItem.notify(queue: .main) {
    print("WorkItem - завершен")
}

// проверка отменена ли работа workItem
workItem.isCancelled

// Отмена блока
workItem.cancel()

workItem.isCancelled

// задержка для кода ниже пока workItem не будет выполнен
workItem.wait()
