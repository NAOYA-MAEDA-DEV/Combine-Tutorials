import Combine
//: # Range
/*:
 `CountableClosedRange` 型のオブジェクトからPublisherを生成することができます。`CountableClosedRange` 型オブジェクトの`publisher` プロパティから取得したPublisherは、Subscribeした時点で「範囲内の整数値」を「値」としてPublishしていき、最後に「イベントの完了」をPublishします。以下のサンプルコードでは、「0、1、2、3」を「値」として持つPublisherを、`sink(receiveCompletion:receiveValue:)` メソッドでSubscribeして、クロージャ内で受信した「値」を処理しています。全ての「値」をPublishしたら、最後に「イベントの完了」をPublishしています。
 */
let publisher = (0 ... 3).publisher

publisher
    .sink(receiveCompletion: {completion in
        print(completion)
    }, receiveValue: { value in
        print(value)
    })
