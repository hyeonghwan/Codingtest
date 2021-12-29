import Foundation
//
//let add_1 = add(num: 1)
//let add_2 = add(num: 1)
//
//add_1() // 1
//add_1() // 2
//add_1() // 3
//
//add_2() // 1
//add_2() // 2
//add_2() // 3
//    for i in 1..<rows + 1{
//        for j in 1..<columns + 1{
//            array.append((i-1)*columns + j)
//        }
//        board.append(array)
//        array.removeAll()
//    }
//    board.removeFirst()
struct Queue<T> {
    private var queue: [Int] = []
    
    public var count:Int {
        return queue.count
    }
    public var isEmpty: Bool {
        return queue.isEmpty
    }
    public var min: Int {
        return queue.min()!
    }
    mutating func enqueue(_ element: Int){
        queue.append(element)
    }
    mutating func dequeue() -> Int {
        return queue.removeFirst()
    }
}
func rotation(_ start: (Int,Int), _ end: (Int,Int),_ board: [[Int]]) -> ([[Int]],Int){
    var (row1,col1) = start
    var (row2,col2) = end
    var rotatedBorad = board
    var queue = Queue<Int>()
    var index: [(Int,Int)] = []
    var temp = (0,0)
    
    for i in col1...col2{
        queue.enqueue(board[row1][i])
        temp = (row1,i)
        index.append(temp)
    }
    for j in (row1+1)...row2{
        queue.enqueue(board[j][col2])
        temp = (j,col2)
        index.append(temp)
    }
    for back in stride(from: col2-1, to: col1, by: -1){
        queue.enqueue(board[row2][back])
        temp = (row2,back)
        index.append(temp)
    }
    for up_row in stride(from: row2, to: row1, by: -1){
        queue.enqueue(board[up_row][col1])
        temp = (up_row,col1)
        index.append(temp)
    }
    var m = queue.min
    var a = index.removeFirst()
    index.forEach{
        rotatedBorad[$0][$1] = queue.dequeue()
    }
    rotatedBorad[a.0][a.1] = queue.dequeue()

    return (rotatedBorad,m)
}

func solution(_ rows:Int, _ columns:Int, _ queries:[[Int]]) -> [Int] {
    var board: [[Int]] = [[]]
    var arr: [Int] = []
    for i in 1..<rows+1{
        let intArray = Array<Int>(((i-1)*columns + 1)...((i-1)*columns + columns))
        board.append(intArray)
    }
    board.removeFirst()
    var rotatedBoard = board
    var minIndex = 0

    for i in 0..<queries.count{
        (rotatedBoard,minIndex) = rotation((queries[i][0]-1,queries[i][1]-1), (queries[i][2]-1,queries[i][3]-1), rotatedBoard)
        arr.append(minIndex)
    }
    return arr
}
var s = solution(6, 6, [[2,2,5,4],[3,3,6,6],[5,1,6,3]])





//import Foundation
//
//func solution(_ progresess: [Int],_ speeds:[Int]) -> [Int] {
//
////    print(zip(progresess,speeds).enumerated())
////    var tuple = zip(progresess,speeds).enumerated()
////    tuple.forEach{
////        print("\($0),\($1)")
////    }
//
//   var sex = zip(progresess, speeds)
//        .map{Int(ceil(Double(100 - $0) / Double($1)))}
//        .reduce(([],0)){ (tuple,day) -> ([Int],Int) in
//            let (list,lastDay) = tuple
//
//            guard let lastCount = list.last else {
//                return ([1],day)
//            }
//            if lastDay >= day{
//                return (list.dropLast() + [lastCount + 1],lastDay)
//            }
//            return (list + [1],day)
//        }
//
//    print(sex)
//    return sex.0
//}
//var sex = solution([90,89], [5,5])
//print(sex)


//    [], 0)
//    ([1], 1)
//    ([1, 1], 14)
//    ([1, 1, 1], 45)


//(([], 0),     1)
//(([1], 1),     14)
//(([1, 1], 14)  ,  45)
//([1, 1, 1], 45)

//func solution(_ arr1:[[Int]], _ arr2:[[Int]]) -> [[Int]] {
//
//    var resultArray = [[Int]]()
//
//    let a = arr1.flatMap { $0 }
//    let b = arr2.flatMap { $0 }
//
//    //arr2 두번째 배열의 갯수
//    let sumCount = arr2[0].count
//
//    var sumArray = [Int]()
//
//    a.enumerated().forEach{
//        index,num in
//        print("\(index), \(num)")
//    }
//    a.enumerated().forEach { index, num in
//        sumArray.append(num + b[index])
//        if sumArray.count == sumCount {
//            resultArray.append(sumArray)
//            sumArray.removeAll()
//        }
//    }
//
//    return resultArray
//}
//var sex = solution([[1,2],[3,4]], [[3,4],[5,6]])
//print(sex)


//struct Queue<T>{
//    private var queue: [Int] = []
//    private var day: [Int] = []
//    public var count: Int {
//        return queue.count
//    }
//    public var isEmpty: Bool {
//        return queue.isEmpty
//    }
//    public mutating func enqueue(_ element: Int) {
//        queue.append(element)
//        day.append(0)
//    }
//    public mutating func dequeue() -> Int {
//        return queue.removeFirst()
//    }
//    public mutating func update(_ index: Int ,_ speed: Int){
//        queue[index] += speed
//        day[index] += 1
//    }
//    public mutating func dayOfTask() -> Int {
//        return day.removeFirst()
//    }
//    public mutating func firstTask() -> Int {
//        return queue.first!
//    }
//}
//func resultCount(_ result: [Int]) -> [Int]{
//    var array: [Int] = []
//    var count = 1
//    for i in 0..<result.count - 1 {
//        if result[i] == result[i+1]{
//            count += 1
//        }else {
//            array.append(count)
//            count = 1
//        }
//    }
//    array.append(count)
//    return array
//}
//func solution(_ progresses:[Int], _ speeds:[Int]) -> [Int] {
//
//    var task = Queue<Int>()
//    var resultDay = [Int]()
//    var speed = speeds
//
//    for i in 0..<progresses.count{
//        //큐에 테스크를 삽입 먼저 해야함 삽입하면서 Day의 날짜도 삽입
//        task.enqueue(progresses[i])
//    }
//    print(task)
//
//    while !task.isEmpty{
//        for j in 0..<task.count{
//            task.update(j, speed[j])
//        }
//        for _ in 0..<task.count{
//            if task.firstTask() >= 100 {
//                resultDay.append(task.dayOfTask())
//                task.dequeue()
//                speed.removeFirst()
//            }
//        }
//    }
//    print(resultDay)
//    return resultCount(resultDay)
//}
//
//var task = solution([1,1,1,1] , [2,1,1,1])
//print(task)

//func solution(_ s:String) -> Int {
//    return press_Str(string: s , length: 1).count
//}
//func press_Str(string input: String, length len: Int) -> String{
//    var input_string = input
//    if len > input.count / 2{
//        return input
//    }
//
//    var curent = ""
//    var count = 1
//    var result = ""
//    for str in input_string.slice(len){
//        if str != curent{
//            result += resultString(curent, count)
//            curent = str
//            count = 1
//        }else{
//            count += 1
//        }
//    }
//    result += resultString(curent, count)
//
//   var result2 = press_Str(string: input_string, length: len + 1)
//
//    if result.count > result2.count{
//        return result2
//    }
//        return result
//}
//func resultString(_ current: String, _ count: Int) -> String{
//
//    if count > 1{
//        return "\(count)" + current
//    }else {
//        return current
//    }
//
//}
//extension String{
//    func slice(_ len: Int) -> [String]{
//         var startIndex = self.startIndex
//        var result: [Substring] = []
//
//        while startIndex < self.endIndex{
//            let endIndex = self.index(startIndex, offsetBy: len, limitedBy: self.endIndex) ?? self.endIndex
//            result.append(self[startIndex..<endIndex])
//            startIndex = endIndex
//        }
//
//
//        return result.map{String($0)}
//    }
//}
//
//var es = solution("aabbaccc")
//print(es)
    
//func solution(_ dartResult:String) -> Int {

//    var dartStr: [String] = dartResult.map{String($0)}
//    var gradeStack = [Int]()
//
//
//    for i in 0..<dartStr.count-1{
//       if dartStr[i] == "1" && dartStr[i+1] == "0"{
//               dartStr[i] = "10"
//               dartStr[i+1] = ""
//       }
//    }
//    print(dartStr)
//
//    for chr in dartStr {
//        var now: Int = 0
//        var before: Int = 0
//        switch chr {
//        case "0","1","2","3","4","5","6","7","8","9","10":
//            if let number = Int(String(chr)){
//            gradeStack.append(number)
//            }
//            continue
//        case "S":
//            now = gradeStack.popLast() ?? 0
//            gradeStack.append(now)
//            continue
//        case "D":
//            now = gradeStack.popLast() ?? 0
//            gradeStack.append(now*now)
//            continue
//        case "T":
//            now = gradeStack.popLast() ?? 0
//            gradeStack.append(now * now * now)
//            continue
//        case "*":
//            if gradeStack.count >= 2{
//                now = gradeStack.popLast() ?? 0
//                before = gradeStack.popLast() ?? 0
//                gradeStack.append(before * 2)
//                gradeStack.append(now * 2)
//            } else if gradeStack.count == 1{
//                now = gradeStack.popLast() ?? 0
//                gradeStack.append(now * 2)
//            }
//            continue
//        case "#":
//            now = gradeStack.popLast() ?? 0
//            gradeStack.append(now * -1)
//            continue
//        default:
//            continue
//        }
//    }
//
//    var totalGrade = 0
//    for i in 0..<gradeStack.count{
//        totalGrade += gradeStack[i]
//    }
//    return totalGrade
//}
//
//
////0T1D2S#5S
//var dart = solution("10D2S3T*")
//print(dart)
//
//
//func solution1(_ N:Int, _ stages:[Int]) -> [Int] {
//    var faliRateResult = [Double]()
//    var index = [Int]()
//    for i in 1..<N + 1 {
//        var stageTotalPlayer = 0.0
//        var notClearPlayer = 0.0
//        for j in 0..<stages.count{
//            if i < stages[j]{
//                 stageTotalPlayer += 1
//            }else if i == stages[j]{
//                stageTotalPlayer += 1
//                notClearPlayer += 1
//            }else{ continue }
//        }
//        faliRateResult.append(notClearPlayer/stageTotalPlayer)
//        index.append(i)
//    }
//
//    for i in 0..<index.count{
//        for j in 0..<(index.count - i - 1){
//            if faliRateResult[j] < faliRateResult[j+1]{
//                faliRateResult.swapAt(j, j+1)
//                index.swapAt(j, j+1)
//            }
//        }
//    }
//
//    return index
//}
//
//var failRate = solution1(5, [2,1,2,6,2,4,3,3])



//스위프트 Self 사용예시
//class NetworkManager {
//    class var maximumActiveRequests: Int {
//        return 4
//    }
//
//    func printDebugData() {
//        print("Maximum network requests: \(Self.maximumActiveRequests).")
//    }
//}
//class ThrottledNetworkManager: NetworkManager {
//    override class var maximumActiveRequests: Int {
//        return 1
//    }
//}
//
//var park = ThrottledNetworkManager()
//park.printDebugData()
