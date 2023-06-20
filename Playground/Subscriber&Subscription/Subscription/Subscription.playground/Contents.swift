import UIKit
import Combine
//: # Subscription
/*:
 以下のサンプルコードでは、Reciverクラスの`init()` メソッド内でPublisherを`sink(receiveValue:)` メソッドでSubscribeしています。そして、`sink(receiveValue:)` メソッドから返されるSubscriptionを、`subscription` プロパティで保持しています。その結果、Subscribeしている状態は維持され、イベントがPublishされる度に`sink(receiveValue:)` メソッドで定義したクロージャが実行されます。また、`AnyCancellable` 型には`cancel()` メソッドが用意されています。任意のタイミングで保持しているSubscriptionを破棄することができます。`cancel()` メソッドを実行すると、保持していたSubscriptionが破棄され、以降は`send(_:)` メソッドでイベントをPublishしても、Subscriberで定義したクロージャは実行されなくなります。
 */
let subject = PassthroughSubject<String, Never>()

final class Receiver {
    let subscription: AnyCancellable
    
    init() {
        subscription = subject
            .sink { value in
                print("Received value:", value)
            }
    }
}

let receiver = Receiver()
subject.send("😇")
subject.send("😀")
subject.send("🥳")
subject.send("😊")
receiver.subscription.cancel()
subject.send("🤩")
subject.send(completion: .finished)
