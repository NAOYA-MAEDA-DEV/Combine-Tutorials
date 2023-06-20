import UIKit
import Combine

let myNotification = Notification.Name("MyNotification")
let publisher = NotificationCenter.default.publisher(for: myNotification)

publisher.sink(receiveCompletion: { completion in
    print(completion)
}, receiveValue: { value in
    print(value)
})

NotificationCenter.default.post(Notification(name: myNotification))
