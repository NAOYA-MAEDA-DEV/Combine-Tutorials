import Combine
//: # Publisher
//: ## イベントを発行するオブジェクトをPublisherといいます。PublisherをSubscribeすることで、PublisherからPublishされたイベントを受信することができます。
//: ---
/*:
 以下のサンプルコードでは、配列からPublisherを生成しています。Publisherを`sink(receiveCompletion:receiveValue:)` メソッドでSubscribeして、Publishさ
 れた「値」をクロージャ内で受信しています。
 */
let publisher = ["😇", "😀", "🥳", "😊", "🤩"].publisher

publisher
    .sink(receiveCompletion: {completion in
        print("Received completion: ", completion)
    }, receiveValue: { value in
        print("Received value: ", value)
    })

