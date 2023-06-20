import UIKit
import Combine
//: # Subscriptions
/*:
 一つのPublisherに対して、複数のSubscribeを行うことができます。この場合、それぞれのSubscriberが返すSubscriptionを保持し続ける必要があります。
 */
let subject = PassthroughSubject<String, Never>()

final class ReceiverSample {
    var firstSubscription: AnyCancellable
    var secondSubscription: AnyCancellable
    
    init() {
        firstSubscription = subject
            .sink { value in
                print("Received value:", value)
            }
        
        secondSubscription = subject
            .sink { value in
                print("Received value:", value)
            }
    }
}

do {
    let receiver = ReceiverSample()
    subject.send("😇")
    subject.send("😀")
    subject.send("🥳")
    subject.send("😊")
}

subject.send("🤩")
