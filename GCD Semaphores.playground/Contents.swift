import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

// Создаем очередь
let queue = DispatchQueue(label: "semaphores", attributes: .concurrent)

// Создаем семафор, указываем сколько потоков
let semaphore = DispatchSemaphore(value: 2)

// Код выполняется асинхронно в два потока, так как в первом потоке код выполняется 4 секунды, то во втором потоке весь код выполнится

queue.async {
    semaphore.wait(timeout: .distantFuture)
    Thread.sleep(forTimeInterval: 4) // усыпили на 4 секунды
    print("Block 1")
    semaphore.signal() // разрешаем следующему потоку заходить
}

queue.async {
    semaphore.wait(timeout: .distantFuture)
    Thread.sleep(forTimeInterval: 2)
    print("Block 2")
    semaphore.signal() // разрешаем следующему потоку заходить
}


queue.async {
    semaphore.wait(timeout: .distantFuture)
    print("Block 3")
    semaphore.signal() // разрешаем следующему потоку заходить
}


queue.async {
    semaphore.wait(timeout: .distantFuture)
    print("Block 4")
    semaphore.signal() // разрешаем следующему потоку заходить
}

