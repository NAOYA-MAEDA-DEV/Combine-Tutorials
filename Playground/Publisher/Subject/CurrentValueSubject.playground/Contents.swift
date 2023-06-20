import Combine
//: # CurrentValueSubject
/*:
 `CurrentValueSubject` はSubjectの一種で、最後にPublishした「値」を保持することができます。オブジェクト生成時にPublishする値の型とエラーの型を型引数で指定することに加え、初期値として保持する値を指定します。また、`CurrentValueSubject` オブジェクトはSubscribeした時点で保持している値をPublishします。
 */
example("CurrentValueSubject") {
    let subject = CurrentValueSubject<String, MyError>("🍎")
    
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
    
    subject
        .sink(receiveCompletion: {completion in
            print("Received completion: ", completion)
        }, receiveValue: { value in
            print("Received value: ", value)
        })
}
