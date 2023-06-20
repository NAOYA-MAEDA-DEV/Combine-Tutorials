import Combine
//: # PassthroughSubject
/*:
 `PassthroughSubject` はSubjectの一種です。オブジェクト生成時にPublishする値の型とエラーの型を型引数で指定します。以下のサンプルコードでは、
 Publishする値の型は`String` 型、エラーは`MyError` 型の`PassthroughSubject` オブジェクトを生成しています。
 */
example("PassthroughSubject<String, MyError>") {
    let subject = PassthroughSubject<String, MyError>()
    
    subject
        .sink(receiveCompletion: {completion in
            print("Received completion: ", completion)
        }, receiveValue: { value in
            print("Received value: ", value)
        })
    
    subject.send("😇")
    subject.send("😀")
    subject.send("🥳")
    subject.send("😊")
    subject.send(completion: .failure(.failed))
    subject.send("🤩")
}
/*:
 エラーの型に`Never` 型を指定すると、「イベントの失敗」をPublishすることができないSubjectを生成することができます。以下のサンプルコードでは、エラーの型が`Never` 型の`PassthroughSubject` オブジェクトを生成しています。エラーの型が`Never` 型なので、「イベントの失敗」をPublishしようとするとビルドエラーになります。
 */
example("PassthroughSubject<String, Never>") {
    let subject = PassthroughSubject<String, Never>()
    
    subject
        .sink(receiveCompletion: {completion in
            print("Received completion: ", completion)
        }, receiveValue: { value in
            print("Received value: ", value)
        })
    
    subject.send("😇")
    subject.send("😀")
    subject.send("🥳")
    subject.send("😊")
    //   subject.send(completion: .failure(.failed))
    subject.send("🤩")
}
