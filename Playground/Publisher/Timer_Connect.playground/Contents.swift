import Foundation
import Combine
//: # Timer (connect)
/*:
 `Timer` 型オブジェクトからPublisherを生成することができます。`Timer` 型オブジェクトの`publish(every:tolerance:on:in:options:)` メソッドから取得したPublisherは、「現在の日時」を「値」としてPublishし続けます。ただし、他のPublisherと違い、Subscribeした時点で「値」はPublishされません。「値」をPublishするためには、`connect()` メソッドを実行する必要があります。以下のサンプルコードでは、「現在の日時」を「値」として持つPublisherを、`sink(receiveCompletion:receiveValue:)` メソッドでSubscribeして、クロージャ内で受信した「値」を処理しています。
 */
var subscription: AnyCancellable

let publisher = Timer.publish(every: 1, on: .main, in: .common)

subscription = publisher
    .sink(receiveCompletion: {completion in
        print("Received completion: ", completion)
    }, receiveValue: { value in
        print("Received value: ", value)
    })

publisher.connect()
//: > `AnyCancellable` 型については「Subscribe&Subscription」で説明しますので、現時点では深追いする必要はありません。

