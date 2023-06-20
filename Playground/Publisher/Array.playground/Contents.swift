import Combine
//: # Array
/*:
 `Sequence` プロトコルには`publisher` プロパティが用意されており、配列からPublisherを生成することができます。配列の`publisher` プロパティから取得したPublisherは、Subscribeした時点で「配列の要素」を「値」としてPublishしていき、最後に「イベントの完了」をPublishします。以下のサンプルコードでは、「"😇"、"😀"、"🥳"、"😊"、"🤩"」を「値」として持つPublisherを、`sink(receiveCompletion:receiveValue:)` メソッドでSubscribeして、クロージャ内で受信した「値」を処理しています。全ての「値」をPublishしたら、最後に「イベントの完了」をPublishします。
 */
let publisher = ["😇", "😀", "🥳", "😊", "🤩"].publisher

publisher
    .sink(receiveCompletion: {completion in
        print("Received completion: ", completion)
    }, receiveValue: { value in
        print("Received value: ", value)
    })

