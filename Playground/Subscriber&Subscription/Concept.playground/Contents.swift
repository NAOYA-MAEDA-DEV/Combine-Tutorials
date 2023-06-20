import UIKit
import Combine
//: # Subscriber&Subscription
//: ## PublisherからPublishされたイベントを、受信することができるように設定するメソッドのことを「Subscriber」といいます。例えば、`sink(receiveValue:)` メソッドは「Subscriber」の一種です。`sink(receiveValue:)` メソッドは`AnyCancellable` 型のオブジェクトを返します。これを「Subscription」といいます。「Subscription」を保持している間は、「Subscribe」している状態を維持することができます。
//: ---
/*:
 以下のサンプルコードでは、Reciverクラスの`init()` メソッド内でPublisherを`sink(receiveValue:)` メソッドでSubscribeしています。しかし、`sink(receiveValue:)` メソッドから返される「Subscription」を保持していないため、イベントをPublishしても`sink(receiveValue:)` メソッドに指定したクロージャは実行されません。
 */
let subject = PassthroughSubject<String, Never>()

final class Receiver {
    init() {
        subject
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
subject.send("🤩")
