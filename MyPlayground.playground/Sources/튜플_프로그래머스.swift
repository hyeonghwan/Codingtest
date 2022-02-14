
import Foundation

func solution(_ s:String) -> [Int] {
    let sk = s
    var str: [[Int]] = []
    var ak = sk.split(separator: "{").map{String($0)}
    for i in 0..<ak.count{
        ak[i].change()
        let slicedArray = ak[i].split(separator: " ").map{String($0)}
        str.append(slicedArray.toInteger())
    }
    str = str.sorted{
        $0.count < $1.count
    }
    var arr: [Int] = []
    str.forEach{
        $0.forEach{ element in
            if !arr.contains(element){
                arr.append(element)
            }
        }
    }
    return arr
}
extension Array where Element == String{
    func toInteger() -> [Int] {
        return self.map{Int($0)!}
    }
}
extension String {
    mutating func change() {
       self = self
               .replacingOccurrences(of: "}", with: "")
               .replacingOccurrences(of: ",", with: " ")
    }
}
