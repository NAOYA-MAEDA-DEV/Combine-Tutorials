import Combine
/*:
# sink
 `sink(receiveValue:)` メソッドは、「Subscriber」の一種です。`sink(receiveValue:)` メソッドの引数に指定したクロージャで、受信したイベントを受信することができます。
*/
example("sinc - 1") {
    let subject = PassthroughSubject<String, Never>()
    var subscriptions = Set<AnyCancellable>()
    
    subject
        .sink { value in
            print(value)
        }
        .store(in: &subscriptions)
    
    subject.send("🥳")
    subject.send("😀")
    subject.send("😇")
}
/*:
 `sink(receiveCompletion:receiveValue:)` メソッドは、値だけではなく、「イベントの完了」と「イベントの失敗」を受信することができます。
*/
example("sinc - 2") {
    let subject = PassthroughSubject<Int, Never>()
    var subscriptions = Set<AnyCancellable>()
    
    subject
        .sink(receiveCompletion: {completion in
            print(completion)
        }, receiveValue: { value in
            print(value)
        })
        .store(in: &subscriptions)
    
    subject.send(0)
    subject.send(1)
    subject.send(2)
    subject.send(3)
    subject.send(completion: .finished)
}
/*:
 処理の失敗や処理の完了を表すイベントを受信した後は、Publisherから値やイベントを受信することができなくなります。
*/
example("sinc - 3") {
    let subject = PassthroughSubject<Int, Never>()
    var subscriptions = Set<AnyCancellable>()
    
    subject
        .sink(receiveCompletion: {completion in
            print(completion)
        }, receiveValue: { value in
            print(value)
        })
        .store(in: &subscriptions)
    
    subject.send(0)
    subject.send(1)
    subject.send(2)
    subject.send(completion: .finished)
    subject.send(3)
}
