import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

/*
Источники отправки - объекты которые позволяют следить за низкоуровневыми процессами
Dispatch Sources Types:
 timer          - периодические уведомления
 signal         - уведомления о UNIX-сигнале
 descriptor     - уведомления о файловых или сокет операциях
 process        - уведомления о событиях связанных с процессом
 mach           - уведомления о событиях связанных с mach портом
 
Этапы создания Dispatch Sources:
 1. Создаем источник отправки
 2. Настраиваем источник отправки
 3. Назначаем нам обработчик отмены работы источника отправки
 4. Запускаем .resume для того, чтобы запустить процессы
*/

// Создали очередь
let queue = DispatchQueue(label: "sources", attributes: .concurrent)

// Создали таймер и поместили в очередь
let timer = DispatchSource.makeTimerSource(queue: queue)

// Настраиваем таймер
// deadline     - когда начинает работать
// repeating    - как часто повторяется
// leeway       - возможное запаздывание
var count = 0
timer.schedule(deadline: .now(), repeating: .seconds(2), leeway: .milliseconds(300))
timer.setEventHandler {
    print("Hello, guys! \(count)")
    if count == 4 {
        timer.cancel()
    }
    count += 1
}

// Блок отмены таймера
timer.setCancelHandler {
    print("Im done! Timer is canseled")
}

// Запустили таймер
timer.resume()

