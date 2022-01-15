import Foundation

func solution(_ priorities:[Int], _ location:Int) -> Int {
    
    var priority = priorities
    var p: [(Int,Int)] = []
    var queue: [Int] = []
    for i in priority.indices{
        p.append((priority[i],i))
    }
    priority = priority.sorted(by: >)
    while !priority.isEmpty{
        if p.first!.0 == priority.first! {
            queue.append(p.first!.1)
            p.removeFirst()
            priority.removeFirst()
        }else{
            let a = p.removeFirst()
            p.append(a)
        }
    }
    var result = 0
    
    for i in 0..<queue.count{
        if queue[i] == location {
            result = i + 1
            break
        }
    }
  
    return result
}

//import Foundation
//
//func solution(_ priorities:[Int], _ location:Int) -> Int {
//    var priority = priorities
//    var queue: [Int] = []
//    var head = 0
//    while queue.count != priority.count{
//        for j in 0..<priority.count{
//            if priority[head] < priority[j]{
//                head = j
//            }
//        }
//        queue.append(head)
//        priority[head] = -1
//        if head >= priority.count - 1 {
//            head = 0
//        }else{
//            head += 1
//        }
//    }
//
//    var result = 0
//    for i in 0..<queue.count{
//        if location == queue[i]{
//            result = i + 1
//        }
//    }
//    return result
//}
