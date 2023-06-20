import UIKit
import Combine
//: # store(in:)
/*:
 複数のSubscribeを行う時、Subscriberの数だけ`AnyCancellable` 型のオブジェクトを用意するのは少し煩わしいです。そこで、`Set<AnyCancellable>()` オブジェクトと`store(in:)` メソッドを使用することで、一つの`Set<AnyCancellable>` 型のオブジェクトで、複数のSubscriptionを管理することができます。以下のサンプルコードでは、`subject` が二度Subscribeされていますが、それぞれのsubscriptionは`store(in:)` メソッドの引数に指定した、`Set<AnyCancellable>`型オブジェクト`のsubscriptions`に格納されています。
 */
let subject = PassthroughSubject<String, Never>()

final class Receiver {
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        subject
            .sink { value in
                print("Received value:", value)
            }
            .store(in: &subscriptions)
        
        subject
            .sink { value in
                print("Received value:", value)
            }
            .store(in: &subscriptions)
    }
}

do {
    let receiver = Receiver()
    subject.send("😇")
    subject.send("😀")
    subject.send("🥳")
    subject.send("😊")
}

subject.send("🤩")
//: > `Set<AnyCancellable>` 型オブジェクトの`subscriptions` プロパティが破棄されたタイミングで、`subscriptions` プロパティに格納されていたSubscriptionは自動で破棄されます。上記のサンプルコードでは、スコープを抜けると`Receiver` クラスのオブジェクトである`receiver` 変数は破棄されます。その結果、`subject` 変数はどこからもSubscribeされていなため、スコープを抜けた後にイベントをPublishしても、何も発生しなくなります。
