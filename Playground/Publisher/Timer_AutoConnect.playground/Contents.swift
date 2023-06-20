import Foundation
import Combine
//: # Timer (autoconnect)
/*: `Timer` 型オブジェクトから取得したPublisherは、`autoconnect()` メソッドを実行した後にSubscribeを行うと、Subscribeした時点で「値」がPublishされます。以下のサンプルコードでは、`connect()` メソッドを実行していませんが、PublisherをSubscribeした時点で「現在の日時」を「値」としてPublishしています。
 */
var subscription: AnyCancellable

let publisher = Timer.publish(every: 1, on: .main, in: .common)

subscription = publisher
    .autoconnect()
    .sink(receiveCompletion: {completion in
        print("Received completion: ", completion)
    }, receiveValue: { value in
        print("Received value: ", value)
    })
//: > `AnyCancellable` 型については「Subscribe&Subscription」で説明しますので、現時点では深追いする必要はありません。
