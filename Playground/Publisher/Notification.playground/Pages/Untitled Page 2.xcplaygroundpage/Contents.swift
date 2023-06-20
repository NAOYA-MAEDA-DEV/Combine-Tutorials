import Foundation
import Combine
//: # Notification
/*: `NotificationCenter` 型のオブジェクトからPublisherを生成することができます。`NotificationCenter` 型オブジェクトの`publisher` プロパティから取得したPublisherは、Publisher生成時に指定した通知がポストされた時にイベントをPublishします。
 */
let myNotification = Notification.Name("MyNotification")
let publisher = NotificationCenter.default.publisher(for: myNotification)

publisher
    .sink(receiveCompletion: {completion in
        print(completion)
    }, receiveValue: { value in
        print(value)
    })

NotificationCenter.default.post(Notification(name: myNotification))


