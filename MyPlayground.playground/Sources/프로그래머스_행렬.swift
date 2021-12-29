import Foundation

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
