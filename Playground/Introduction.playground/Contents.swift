//: # Introduction
//: ## Combine is a genuine Apple framework for reactive programming in Swift that allows events occurring in one object to be propagated to another object. Events can be classified into three types
/*:
 * ## Value
 * ## Completion
 * ## Failure
 */
//: ## A "value" is a "value" itself, such as "1" or ""Swift"". It may seem a little strange to call a mere "value" an event, but in Combine, "value" itself is also treated as an event. Event Completion" is an event to inform the destination object that all event transmissions are complete. Failure" is an event to inform the destination object that the transmission of an event has failed for some reason.
//: ## The following three items are important to learn about Combine.
/*:
 * ## Publisher
 * ## Subscriber
 * ## Operator
 */
//: ## Publishers can publish events. A "Subscriber" can subscribe to events published by the "Publisher". When a Subscriber subscribes to a Publisher, it can receive events published by the Publisher within the closure defined in the Subscriber. The Operator can add processing to the events published by the Publisher, and can subscribe to the processed events.
//: ## Now, let's see what we have described so far in code.
//: ---
import Combine

example("Sending string values and receiving string values") {
    let subject = PassthroughSubject<Int, Never>() // Generate Publisher
    
    subject // Publisher
        .map { String($0) } // Operator
        .sink { value in // Subscriber
            print(value) // Handle value events
        }
    
    subject.send(0) // Publish value event
    subject.send(1) // Publish value event
    subject.send(2) // Publish value event
}
/*:
 `PassthroughSubject<String, Never>` 型は「Publisher」の役割を果たす型です。`send(_:)` メソッドで、イベントをPublishすることができます。`sink(receiveValue:)` メソッド は「Subscriber」の役割を果たすメソッドです。引数に指定したクロージャで、Publishされたイベントを受信することができます。`map(_:)` は「Operator」の役割を果たすメソッドです。サンプルコードでは、Publisherが整数値「0, 1, 2」をPublishし、Operatorが文字列「"0", "1", "2"」に変換、そして、`sink(receiveValue:)` メソッドの引数に指定したクロージャでPublishされた文字列「"0", "1", "2"」をコンソールに出力しています。
*/
//: > 上記サンプルコード内で使用している型やメソッドは別の章で解説しますので、現時点で詳細を深い追いする必要はありません。

//: 上記のサンプルコードで使用している`sink(receiveValue:)` は「値」のみ受信することができるSubscribeメソッドです。「イベントの完了」や「イベントの失敗」を受信するためには、`sink(receiveCompletion:receiveValue:)` メソッドを使用します。`receiveCompletion:` に指定したクロージャ内で「イベントの完了」と「イベントの失敗」を受信することができ、`receiveValue:` に指定したクロージャ内で「値」を受信することができます。
example("Sending string values and receiving string values and event") {
    let subject = PassthroughSubject<Int, Never>() // Generate Publisher
    
    subject // Publisher
        .map { String($0) } // Operator
        .sink(receiveCompletion: {completion in // Subscriber
            print(completion) // Handle completion or failure events
        }, receiveValue: { value in
            print(value) // Handle value events
        })
    
    subject.send(0) // Publish value event
    subject.send(1) // Publish value event
    subject.send(2) // Publish value event
    subject.send(completion: .finished) // Publish completion event
    subject.send(3) // Publish value event
}
//: > イベントの完了やイベントの失敗をPublishした後は、`send(_:)` メソッドで値をPublishしても、Subscribeメソッド内でイベントの受信は行われません。
