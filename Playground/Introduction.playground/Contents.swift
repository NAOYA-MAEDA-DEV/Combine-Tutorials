//: # Introduction
//: ## CombineはSwiftでリアクティブプログラミングを行うための、Apple純正のフレームワークです。Combineを使うと、あるオブジェクトで発生したイベントを別のオブジェクトに伝達することができます。イベントは以下の3種類のタイプに分類することができます。
/*:
 * ## 値
 * ## イベントの完了
 * ## イベントの失敗
 */
//: ## 「値」は「1」や「"Swift"」といった「値」そのものです。単なる「値」をイベントと呼ぶのは少々違和感を感じますが、Combineでは「値」そのものもイベントとして扱います。「イベントの完了」はイベントの伝達が全て完了したことを、伝達先のオブジェクトに伝えるためのイベントです。「イベントの失敗」は何かしらの理由でイベントの伝達が失敗したことを、伝達先のオブジェクトに伝えるためのイベントです。
//: ## Combineを学ぶ上で重要な項目は以下の3つです。
/*:
 * ## Publisher (パブリッシャ)
 * ## Subscriber (サブスクライバ)
 * ## Operator (オペレータ)
 */
//: ## 「Publisher」はイベントをPublish(発行)することができます。「Subscriber」は「Publisher」がPublishしたイベントを、Subscribe(購読)することができます。「Publisher」を「Subscriber」でSubscribeすると、「Publisher」からPublishされたイベントを、「Subscriber」内で定義したクロージャ内で受信することができます。「Operator」は「Publisher」がPublishしたイベントに処理を加えることができ、処理を加えたイベントをSubscribeすることができます。
//: ## では、ここまで説明してきた内容をコードで確認します。
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
