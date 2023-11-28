//
//  ViewModel.swift
//  MVVM+Combine
//
//  Created by 오예준 on 2023/11/27.
//

import Foundation
import Combine
import UIKit
protocol ViewModel {
    associatedtype Input
    associatedtype Output
    func transform(_ input: Input) -> Output
}
class LoginViewModel: ViewModel {
    struct Input {
        let id: AnyPublisher<String, Never>
        let pwd: AnyPublisher<String, Never>
        let confirm: AnyPublisher<String, Never>
    }
    
    struct Output {
        let btnState: AnyPublisher<Bool, Never>
    }
    func transform(_ input: Input) -> Output {
        let getBtnState = input.id
            .combineLatest(input.pwd, input.confirm)
            .map { id, pwd, confirm in
                id.count >= 5 && pwd.count >= 7 && (pwd == confirm)
            }
            .eraseToAnyPublisher()
        return Output(btnState: getBtnState)
    }
}


extension UIControl {
    func controlPublisher(for event: UIControl.Event) -> UIControl.EventPublisher {
        return UIControl.EventPublisher(control: self, event: event)
      }
    
    // Publisher
    struct EventPublisher: Publisher {
        typealias Output = UIControl
        typealias Failure = Never
        
        let control: UIControl
        let event: UIControl.Event
        
        func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, UIControl == S.Input {
            let subscription = EventSubscription(control: control, subscrier: subscriber, event: event)
            subscriber.receive(subscription: subscription)
        }
    }
    
    // Subscription
    fileprivate class EventSubscription<EventSubscriber: Subscriber>: Subscription where EventSubscriber.Input == UIControl, EventSubscriber.Failure == Never {

        let control: UIControl
        let event: UIControl.Event
        var subscriber: EventSubscriber?
        
        init(control: UIControl, subscrier: EventSubscriber, event: UIControl.Event) {
            self.control = control
            self.subscriber = subscrier
            self.event = event
            
            control.addTarget(self, action: #selector(eventDidOccur), for: event)
        }
        
        func request(_ demand: Subscribers.Demand) {}
        
        func cancel() {
            subscriber = nil
            control.removeTarget(self, action: #selector(eventDidOccur), for: event)
        }
        
        @objc func eventDidOccur() {
            _ = subscriber?.receive(control)
        }
    }
}

extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        controlPublisher(for: .editingChanged)
            .map { $0 as! UITextField }
            .map { $0.text! }
            .eraseToAnyPublisher()
    }
}
