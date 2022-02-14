import Foundation

func searchRoot(_ check: [Int],_ checkPoint: Int) -> Int {
    var answer = 2 << 17
    var check = check
    let checkPoint = checkPoint
    let strSize = check.count
    print(answer)
    enum R_OR_L{
        case Right,Left
    }
  
    func dfs(_ current: Int,_ R_OR_L: R_OR_L,_ weight: Int,_ len: Int){
        check[current] = 0
        if weight == checkPoint {
            answer = min(answer, len)
            return
        }
        if R_OR_L == .Left {
            var left_Move = 1
            while true{
                if check[(current - left_Move + strSize) % strSize] == 1{
                    break
                }
                left_Move += 1
            }
            let nCurrent = (current - left_Move + strSize) % strSize
            dfs(nCurrent, .Left, weight + 1, len + left_Move)
            check[nCurrent] = 1
            dfs(nCurrent, .Right, weight + 1, len + left_Move)
            check[nCurrent] = 1
        }else{
            var right_Move = 1
            while true{
                if check[(current + right_Move) % strSize] == 1{
                    break
                }
                right_Move += 1
            }
            let nCurrent = (current + right_Move) % strSize
            dfs(nCurrent, .Left, weight + 1, len + right_Move)
            check[nCurrent] = 1
            dfs(nCurrent, .Right, weight + 1, len + right_Move)
            check[nCurrent] = 1
        }
    }
    let weight = check[0] == 0 ? 0 : 1
    let len = 0
    dfs(0, .Left, weight, len)
    dfs(0, .Right, weight, len)
    return answer
}

func solution(_ name:String) -> Int {
    let nameStr = name.map{String($0)}
    var unicodeValue: [Int] = []
    var check = Array(repeating: 0, count: nameStr.count)
    var checkPoint: Int = 0
    for i in 0..<nameStr.count{
        guard let a = UnicodeScalar(nameStr[i])?.value else {return 1}
        var number = Int(a) - 65
        if number > 13{
            number = 26 - number
        }
        if number != 0 {
            check[i] = 1
            checkPoint += 1
        }
        unicodeValue.append(number)
    }
    if checkPoint == 0 {
        return checkPoint
    }
    
    return unicodeValue.reduce(searchRoot(check, checkPoint), +)
}
