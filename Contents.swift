
import Foundation
import Combine
import UIKit


/**
 // Publisher: Uses a timer to emit the date once per second.
 let timerPub = Timer.publish(every: 1, on: .main, in: .default)
 .autoconnect()
 /**
  Sử dụng publisher timer để gửi thời gian.
  Sử dụng Timer.scheduledTimer để gửi yêu cầu theo thời gian, sau 10 giây sẽ gửi yêu cầu 1 lần.
  Sử dụng hàm nhận giá trị mà Publisher trả về để in giá trị mà Publisher gửi đến.
  Thử sử dụng
  */
 
 // Subscriber: Waits 10 seconds after subscription, then requests a
 // maximum of 3 values.
 class MySubscriber: Subscriber {
 
 typealias Input = Date
 typealias Failure = Never
 var subscription: Subscription?
 
 func receive(subscription: Subscription) {
 print("published                             received")
 self.subscription = subscription
 let timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { // sự kiện này có lặp lại sau 10ms 1 lần
 [weak self] timer in
 subscription.request(.max(3)) // subscription gửi yêu cầu cho publisher, và yêu cầu giá trị trả về lớn nhất là 3
 }
 timer.fire()
 }
 
 
 
 func receive(_ input: Date) -> Subscribers.Demand {
 print("\(input)             \(Date())")
 return Subscribers.Demand.none
 }
 
 
 func receive(completion: Subscribers.Completion<Never>) {
 print ("--done--")
 }
 // hàm hoàn thành sau khi publisher đã gửi thành công hết tất cả các giá trị
 }
 
 
 // Subscribe to timerPub.
 let mySub = MySubscriber()
 print ("Subscribing at \(Date())")
 timerPub.subscribe(mySub)
 
 */

// ví dụ đơn giản về hàm sink trong publisher

/**
let array = [1,2,3]

array
    .publisher
    .sink(receiveCompletion: { completion in
        switch completion {
            
        case .failure(let error):
            print("Publisher error")
        case .finished:
            print("Publisher finish")
        }
    },
          receiveValue: { value in
        print("Print value in array: \(value )")
        
    })
*/

// khởi tạo 1 ví dụ: về Notification.Name để thông báo khi có event

// Định nghĩa về một Notification.Name
extension Notification.Name{
    static let newEvent = Notification.Name("new_event")
}
// Định nghĩa về một Event
struct Event{
    let title: String
    let scheduleOn: Date
}

//  Tạo ra 1 Notification Publisher
let eventPublisher = NotificationCenter.Publisher(center: .default, name: .newEvent, object: nil)
    .map { (notification) -> String? in
        // thực hiện ép kiểu đối tượng trong thông báo (notification) thành kiểu Event để kiểm tra title có phải là
    return (notification.object as? Event)?.title ?? ""
        
}
          
let theEventTitleLabel = UILabel()
let newEventLabelSubscriber = Subscribers.Assign(object: theEventTitleLabel, keyPath: \.text)
eventPublisher.subscribe(newEventLabelSubscriber)

let event = Event(title: " Introdution SwiftUI ", scheduleOn: Date())
let event23 = Event(title: " Introdution SwiftUI2222 ", scheduleOn: Date())
let array_event = [event, event23]

for i in array_event{
    NotificationCenter.default.post(name: .newEvent, object: i)
    print(" Recent event notified is: \(theEventTitleLabel.text!)")
}











          
          
          
          
