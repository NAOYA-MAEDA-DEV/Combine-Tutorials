import Combine
//: # Operator
//: ## Operatorは元のPublisherが持つ値を加工して、新たなPublisherを生成することができます。
//: ---
/*:
 以下のサンプルコードでは、元のPublisherが持つ値を2倍し、新たなPublisherを生成しています。
 */

example("Operator") {
    let subject = PassthroughSubject<Int, Never>()
    var subscriptions = Set<AnyCancellable>()
    
    subject
        .map { $0 * 2 }
        .sink { value in
            print(value)
        }
        .store(in: &subscriptions)
    
    subject.send(0)
    subject.send(1)
    subject.send(2)
}
