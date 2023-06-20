import Combine
//: # eraseToAnyPublisher
/*:
 Subjectは自身をSubscribeすることができ、`send(_:)` メソッドでイベントをPublishすることができます。しかし、実際にCombineを使用する時、外部から自由に`send(_:)` メソッドでイベントをPublishさせたくない時があります。そのような時は`eraseToAnyPublisher()` メソッド を使用することで、Subjectを単なるPublisherとすることができます。以下のサンプルコードでは、`CurrentValueSubject` 型のオブジェクトに対して、`eraseToAnyPublisher()` メソッドを実行しています。`subject` 変数は単なるPublisherとなり、`send(_:)` メソッドでイベントをPublishすることができなくなります。
 */
example("eraseToAnyPublisher - 1") {
    let subject = CurrentValueSubject<String, MyError>("🍎").eraseToAnyPublisher()
    
    subject
        .sink(receiveCompletion: {completion in
            print("Received completion: ", completion)
        }, receiveValue: { value in
            print("Received value: ", value)
        })
    
//    subject.send("😇")
}
/*:
 以下の`Receiver` クラスでは、`PassthroughSubject<String, Never>` 型の`subject` プロパティと、`eraseToAnyPublisher()` メソッドで`subject` プロパティをPublisher化した`publisher` プロパティが宣言されています。`subject` プロパティは`private` 修飾子で隠蔽しているので、`Receiver` クラスのオブジェクトを使用する外部から、自由にイベントをPublishさせることを防ぐことができます。
 */
example("eraseToAnyPublisher -2 ") {
    final class Receiver {
        private let subject = PassthroughSubject<String, Never>()
        lazy var publisher = subject.eraseToAnyPublisher()
        
        func sendValue() {
            subject.send("😇")
            subject.send("😀")
            subject.send("🥳")
            subject.send("😊")
        }
    }
    
    let receiver = Receiver()
    
    receiver.publisher
        .sink(receiveCompletion: {completion in
            print("Received completion: ", completion)
        }, receiveValue: { value in
            print("Received value: ", value)
        })
    
    receiver.sendValue()
}
