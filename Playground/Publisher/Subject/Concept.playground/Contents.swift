import Combine
//: # Subject
//: ## SubjectはPublisherの一種です。`send(_:)` メソッドでイベントをPublishすることができます。
//: ---
/*:
 以下のサンプルコードでは、`PassthroughSubject<String, Never>` 型のSubjectを生成し、`send(_:)` メソッドでイベントをPublishしています。
 */
let subject = PassthroughSubject<String, Never>()

subject
    .sink(receiveCompletion: {completion in
        print("Received completion: ", completion)
    }, receiveValue: { value in
        print("Received value: ", value)
    })

subject.send("😇")
subject.send("😀")
subject.send("🥳")
subject.send("😊")
subject.send(completion: .finished)
subject.send("🤩")

//: > イベントの完了やイベントの失敗をPublishした後は、`send(_:)` メソッドで値をPublishしても、Subscribeメソッド内でイベントの受信は行われません。上記サンプルコードで、`subject.send(completion: .finished)` を実行した後は、`subject.send("🤩")` メソッドでイベントがPublishされていません。
