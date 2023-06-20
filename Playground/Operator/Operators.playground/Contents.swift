import UIKit
import Combine
/*:
# map(_:)
 `map(_:)` は元のPublisherが持つ値を変換して、それらの値を要素とする新たなPublisherを生成することができるオペレータです。以下のサンプルコードでは、String型の値を`Int `型にキャストした値を要素とする新たなPublisherを生成しています。
*/
example("map") {
    let publisher = ["1", "2", "3", "😇", "5"].publisher
    var subscriptions = Set<AnyCancellable>()
    
    publisher
        .map { Int($0) }
        .sink(receiveCompletion: {completion in
            print("Received completion: ", completion)
        }, receiveValue: { value in
            print("Received value: ", value ?? "nil")
        }).store(in: &subscriptions)
}
/*:
# scan(_:_:)
 `scan(_:_:)` は元のPublisherが持つ値を変換して、それらの値を要素とする新たなPublisherを生成することができるオペレータです。値を変換するクロージャを実行する際、 前回クロージャを実行した時に生成した値を利用することができます。`scan(_:_:)` メソッドの引数には、初回クロージャ実行時に使用するための初期値を指定します。以下のサンプルコードでは、
 0 (0 + 0), 1 (0 + 1), 3 (1 + 2), 6 (3 + 3), 10 (6 + 4), 15 (10 + 5)と、前回クロージャを実行した時に生成した値を利用して、新たな値を生成しています。
*/
example("scan") {
    let publisher = (0 ... 5).publisher
    var subscriptions = Set<AnyCancellable>()
    
    publisher
        .scan(0) { $0 + $1 }
        .sink(receiveCompletion: {completion in
            print("Received completion: ", completion)
        }, receiveValue: { value in
            print("Received value: ", value)
        }).store(in: &subscriptions)
}
/*:
# filter(_:)
 `filter(_:)` はPublisherが持つ値の中で、条件にマッチした値を要素とする新たなPublisherを生成することができるオペレータです。以下のサンプルコードでは、偶数値(2で割り切ることができる値)を要素とする新たなPublisherを生成しています。
*/
example("Filter") {
    let publisher = [1, 2, 3, 4, 5].publisher
    
    publisher
        .filter { $0 % 2 == 0 }
        .sink(receiveCompletion: {completion in
            print("Received completion: ", completion)
        }, receiveValue: { value in
            print("Received value: ", value)
        })
}
/*:
# compactMap(_:)
 `compactMap(_:)` は元のPublisherが持つ値を変換して、それらの値を要素とする新たなPublisherを生成することができるオペレータです。`map(_:)` メソッドとの違いは、`compactMap(_:)` で加工した値がオプショナルな時はアンラップされ、`nil` は除外されます。以下のサンプルコードでは、String型の値を`Int `型にキャストした値を要素とする新たなPublisherを生成しています。
*/
example("compactMap") {
    let publisher = ["1", "2", "😭", "😇", "5"].publisher
    
    publisher
        .compactMap { Int($0) }
        .sink(receiveCompletion: {completion in
            print("Received completion: ", completion)
        }, receiveValue: { value in
            print("Received value: ", value)
        })
}
/*:
# combineLatest(_:)
 `combineLatest(_:)` は二つのPublisherが持つ値をを合成して新たなPublisherを生成することができるオペレータです。合成元のPublisherのうち、いずれかのPublisherが値をPublishした時に、合成元の各Publisherが最後にPublishした値で合成した値がPublishされます。合成した値をPublishするためには、合成元の各Publisherが少なくとも一度はPublishしている必要があります。
*/
example("combineLatest") {
    let foodSubject = PassthroughSubject<String, Never>()
    let drinkSubject = PassthroughSubject<String, Never>()
    
    foodSubject.combineLatest(drinkSubject) {food, drink in
        food + drink
    }
    .sink(receiveCompletion: {completion in
        print("Received completion: ", completion)
    }, receiveValue: { value in
        print("Received value: ", value)
    })
    
    foodSubject.send("🍙")
    drinkSubject.send("🍵")
    foodSubject.send("🥐")
    foodSubject.send("🍕")
    drinkSubject.send("☕️")
    drinkSubject.send("🍹")
}
