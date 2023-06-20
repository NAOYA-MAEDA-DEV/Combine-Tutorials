import Combine
/*:
# assign
 `assign(to:on:)` メソッドは、「Subscriber」の一種です。受信したイベントを引数に指定したオブジェクトのプロパティに代入します。プロパティはキーパス式で指定します。
*/
let subject = PassthroughSubject<String, Never>()

final class EmojiObject {
    var emoji = "" {
        didSet {
            print("didset value: ", emoji)
        }
    }
}

final class Receiver {
    var subscriptions = Set<AnyCancellable>()
    let emojiObject = EmojiObject()
    
    init() {
        subject
            .assign(to: \.emoji, on: emojiObject)
            .store(in: &subscriptions)
    }
}

let receiver = Receiver()

subject.send("🥳")
subject.send("😀")
subject.send("😇")
