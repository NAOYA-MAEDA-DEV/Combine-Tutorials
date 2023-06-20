import Foundation
import Combine
//: # URLSession
/*: `URLSession` 型のオブジェクトからPublisherを生成することができます。`URLSession` 型オブジェクトから取得したPublisherは、通信に失敗した時はエラーイベントをPublishし、通信に成功すると
 `Data` 型のオブジェクトと`URLResponse` 型のオブジェクトをPublishします。
 */
var subscriptions = Set<AnyCancellable>()

let url = URL(string: "https://www.example.com")!
let publisher = URLSession.shared.dataTaskPublisher(for: url)

publisher
    .sink(receiveCompletion: { completion in
        if completion == .finished {
            print("Received completion")
        } else {
            print("Received error")
        }
    }, receiveValue: { data, response in
        print("Received data:", data)
        print("Received response:", response)
    })
    .store(in: &subscriptions)

//: > `Set<AnyCancellable>` 型、`store(in:)` メソッドについては「Subscribe&Subscription」で説明しますので、現時点では深追いする必要はありません。
