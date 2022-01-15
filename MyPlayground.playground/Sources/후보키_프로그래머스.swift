import Foundation


var combi1: [[Int]] = []
func solution(_ relation:[[String]]) -> Int {

    let row = relation.count
    let column = relation[0].count
    var array: [Int] = []
    for i in 0..<column{
        array.append(i)
    }
    for i in 1..<column + 1{
        combination(array, i, 0, [])
    }
    print(combi1)
    var candyKey: [[Int]] = []
    for i in 0..<combi1.count{

        var flag: Bool = false
            for k in candyKey{
                var count = 0
                for element in k{
                    if combi1[i].contains(element){
                        count += 1
                    }
                }
                if count == k.count { flag = true}
            }
        if flag == true {continue}

        print(combi1[i])
        var str: [[String]] = []
        for j in combi1[i]{
            var check: [String] = []
            for r_index in 0..<row{
                check.append(relation[r_index][j])
            }
            str.append(check)
            }
        print(str)

        var combineArray: [String] = []

            for c_index in 0..<str[0].count {
                var tuple = ""
                for r_index in 0..<str.count{
                     tuple += str[r_index][c_index] + " "
                }
                combineArray.append(tuple)
            }

        print(combineArray)
        let ok = isCheck(combineArray)
        if ok == true{
            candyKey.append(combi1[i])
        }else{
            continue
        }

        print(combineArray)
        print("-----")
    }

    print(candyKey)

    return candyKey.count
}
func isCheck(_ columnArr: [String]) -> Bool {
    let arr = Set(columnArr)
    if arr.count == columnArr.count{
        return true
    }
    return false
}

func combination(_ target:[Int], _ target_num: Int, _ index: Int,_ tmp:[Int]) {
    if tmp.count == target_num{
        combi1.append(tmp)
        return
    }
    for i in index ..< target.count{
        combination(target, target_num, i+1, tmp + [target[i]])
    }
}
