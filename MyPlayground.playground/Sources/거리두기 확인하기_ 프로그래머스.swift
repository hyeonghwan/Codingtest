import Foundation

func solution(_ places:[[String]]) -> [Int] {
    var place: [[String]] = []
    var hoho: [Int] = []
    for room in 0..<places.count{
        var splitPlace = places[room]
        place = splitPlace.slice()
//        print(place)
        
        var point: [(Int,Int)] = []
        for i in 0..<place.count{
            for j in 0..<place[i].count {
                if place[i][j] == "P" {
//                    print("\(i),\(j)")
                    point.append((i,j))
                }
            }
        }
//        print(point)
        if point.count == 1 || point.count == 0 {
            hoho.append(1)
            continue
        }else{

            var flag = 1
            for i in 0..<point.count - 1 {
                for j in i+1..<point.count {
                    if abs(point[i].0 - point[j].0) + abs(point[i].1 - point[j].1) == 1 {
//                        print("\(i),\(j)")
                        flag = 0
                        break
                    }else if abs(point[i].0 - point[j].0) + abs(point[i].1 - point[j].1) <= 2{
                        if certification(point, i, j,place) == false {
                            flag = 0
                            break
                        }
                    }
                }
                if flag == 0 {
                    hoho.append(0)
                    break
                }
            }
            if flag == 1 {
                hoho.append(1)
            }
        }
//        print(hoho)
    }
   
    return hoho
}
func certification(_ point: [(Int,Int)],_ x:Int,_ y: Int,_ place: [[String]])-> Bool {
    let (x1,y1) = point[x]
    let (x2,y2) = point[y]
    let d = abs((x1 - x2) + (y1 - y2))
    var right: String = ""
    var left: String = ""
    var bottom: String = ""
    if y1 == 0 , x1 != 4{
        //right, bottom
        right = place[x1][y1+1]
        bottom = place[x1+1][y1]
    }else if y1 == 4 {
        //left, bottom
        left = place[x1][y1-1]
        bottom = place[x1+1][y1]
    }else if x1 == 4 {
        // right
        right = place[x1][y1+1]
    }
    else {
        //right,left,bottom
        right = place[x1][y1+1]
        left = place[x1][y1-1]
        bottom = place[x1+1][y1]
    }
    if x1 == x2 {
        //행이 같을때
        if right == "O"{
            return false
        }
    }else if x1 != x2 && y1 == y2 {
        //행이 다르고, 열이 같을때
        if bottom == "O"{
            return false
        }
    }else {
        //행 열이 다를때
        if d == 0 {
            if left == "X" && bottom == "X"{
                return true
            }else{
                return false}
        }else {
            if right == "X" && bottom == "X"{
                return true
            }else {return false}
        }
    }
    return true
}

extension Array where Element == String{
    mutating func slice() -> [[String]]{
        var result: [[String]] = []
        var startIndex: String.Index
        var endIndex: String.Index
        for i in 0..<self.count{
            var a: [String] = []
            startIndex = self[i].startIndex
            for _ in 0..<self[i].count{
                endIndex = self[i].index(startIndex, offsetBy: 1)
                let index = self[i].index(startIndex, offsetBy: 0)
                a.append(String(self[i][index]))
                startIndex = endIndex
            }
            result.append(a)
        }
        return result
    }
}
//
//var a = solution([["POOOP", "OXXOX", "OPXPX", "OOXOX", "POXXP"],
//                  ["POOPX", "OXPXP", "PXXXO", "OXXXO", "OOOPP"],
//                  ["PXOPX", "OXOXP", "OXPOX", "OXXOP", "PXPOX"],
//                  ["OOOXX", "XOOOX", "OOOXX", "OXOOX", "OOOOO"],
//                  ["PXPXP", "XPXPX", "PXPXP", "XPXPX", "PXPXP"]])
