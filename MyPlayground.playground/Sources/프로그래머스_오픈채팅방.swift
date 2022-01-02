import Foundation
struct ChatRoom {
    var state: String
    var uuid: String
}

func solution(_ record:[String]) -> [String] {
    var result: [[String]] = []
    var user: [ChatRoom] = []
    var id_name: [String: String] = [:]
    result = record.slice()
    
    
    for str in result{
            if str[0] == "Enter"{
                id_name[str[1]] = str[2]
                let id = ChatRoom(state: str[0], uuid: str[1])
                user.append(id)
            }else if str[0] == "Leave"{
                let id = ChatRoom(state: str[0], uuid: str[1])
                user.append(id)
            }else{
                id_name[str[1]] = str[2]
                continue
            }
    }
    var value: [String] = []

    user.forEach{
        switch $0.state {
        case "Enter":
            value.append("\(id_name[$0.uuid]!)님이 들어왔습니다.")
        default:
            value.append("\(id_name[$0.uuid]!)님이 나갔습니다.")
        }
    }
    return value
}
extension Array{
     func slice() -> [[String]]{
         var result: [[String]] = []
        for i in self as! [String]{
            let a = i.split(separator: " ").map{String($0)}
            result.append(a)
        }
         return result
    }
}
//import Foundation
//
//struct ChatRoom {
//    var state: String
//    var uuid: String
//    var name: String?
//}
//
//func solution(_ record:[String]) -> [String] {
//    var result: [[String]] = []
//    var user: [ChatRoom] = []
//
//    result = record.slice()
//    print(result)
//    for str in result{
//        if str.count > 2{
//            if str[0] == "Change"{
//                for i in 0..<user.count{
//                    if user[i].uuid == str[1]{
//                        user[i].name = str[2]
//                    }
//                }
//                continue
//            }
//            if str[0] == "Enter"{
//                let id = ChatRoom(state: str[0], uuid: str[1], name: str[2])
//                for i in 0..<user.count{
//                    if user[i].uuid == id.uuid{
//                        user[i].name = id.name
//                    }
//                }
//                user.append(id)
//            }
//        }else {
//            var id = ChatRoom(state: str[0], uuid: str[1], name: nil)
//            for i in 0..<user.count{
//                if user[i].uuid == id.uuid{
//                    id.name = user[i].name
//                    break
//                }
//            }
//            user.append(id)
//        }
//    }
//    var value: [String] = []
//
//    user.forEach{
//        switch $0.state {
//        case "Enter":
//            value.append("\($0.name!)님이 들어왔습니다.")
//        default:
//            for i in user {
//                if i.uuid == $0.uuid && i.name != nil {
//                    value.append("\(i.name!)님이 나갔습니다.")
//                    break
//                }
//            }
//        }
//    }
//    return value
//}
//extension Array{
//     func slice() -> [[String]]{
//         var result: [[String]] = []
//        for i in self as! [String]{
//            let a = i.split(separator: " ").map{String($0)}
//            result.append(a)
//        }
//         return result
//    }
//}
//
//var a = solution(["Enter uid1234 Muzi",
//                  "Enter uid4567 Prodo",
//                  "Leave uid1234",
//                  "Enter uid1234 Prodo",
//                  "Change uid4567 Ryan"])
//print(a)
