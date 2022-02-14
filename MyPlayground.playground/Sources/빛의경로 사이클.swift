import Foundation

enum Direction: Equatable,Hashable{
    case north
    case south
    case west
    case east
}
struct MapDirection: Equatable{
    var direction: Direction
    var d: String
    var x: Int
    var y: Int
}

func solution(_ grid:[String]) -> [Int] {
    var gridMap: [[String]] = []
    let allDirection: [Direction] = [.north,.east,.south,.west]
    var arrayOfMapDirection: [MapDirection] = []
    for length in 0..<grid.count{
        var map: [String] = []
        var x = 0
        for str in grid[length]{
            map.append(String(str))
            for dir in allDirection{
                arrayOfMapDirection.append(MapDirection(direction: dir, d: String(str), x: x, y: length))
            }
            x += 1
        }
        gridMap.append(map)
    }
    let visited = Array(repeating: Array(repeating:[Direction.north:false,
                                                    Direction.east:false,
                                                    Direction.south:false,
                                                    Direction.west:false],
                                         count: gridMap[0].count),count: gridMap.count)
 
    return search(arrayOfMapDirection,gridMap,visited).sorted(by: <)
}
func search(_ arrayOfMapDirection1: [MapDirection] ,_ gridMap: [[String]],_ visited: [[[Direction:Bool]]]) -> [Int] {
    let arrayOfMapDirection = arrayOfMapDirection1
    var valueOfDirection: [MapDirection] = []
    var cycleCount: [Int] = []
    var visited = visited
    for i in 0..<arrayOfMapDirection.count{
        let startDirection = arrayOfMapDirection[i]
        var currentX = startDirection.x
        var currentY = startDirection.y
        let pointX = gridMap[0].count - 1 // column
        let pointY = gridMap.count - 1 // row
        if visited[currentY][currentX][startDirection.direction] == false{
            print("StartDirection :: \(startDirection)")
            valueOfDirection.append(startDirection)
        }else{
            continue
        }
        while true{
            let k = valueOfDirection.last!
            let currentDirection: Direction = k.direction
            var directionItem: MapDirection
            switch currentDirection{
            case .north:
                currentY -= 1
                if currentY < 0{
                    currentY = pointY
                }
                let nextWord = gridMap[currentY][currentX]
                if nextWord == "S"{
                    directionItem = MapDirection(direction: .north, d: "S", x: currentX , y: currentY)
                }else if nextWord == "R"{
                    directionItem = MapDirection(direction: .east, d: "R", x: currentX , y: currentY)
                }else{
                    directionItem = MapDirection(direction: .west, d: "L", x: currentX , y: currentY)
                }
            case .east:
                currentX += 1
                if currentX > pointX {
                    currentX = 0
                }
                let nextWord = gridMap[currentY][currentX]
                if nextWord == "S"{
                    directionItem = MapDirection(direction: .east, d: "S", x: currentX , y: currentY)
                }else if nextWord == "R"{
                    directionItem = MapDirection(direction: .south, d: "R", x: currentX , y: currentY)
                }else{
                    directionItem = MapDirection(direction: .north, d: "L", x: currentX , y: currentY)
                }
            case .west:
                currentX -= 1
                if currentX < 0 {
                    currentX = pointX
                }
                let nextWord = gridMap[currentY][currentX]
                if nextWord == "S"{
                    directionItem = MapDirection(direction: .west, d: "S", x: currentX , y: currentY)
                }else if nextWord == "R"{
                    directionItem = MapDirection(direction: .north, d: "R", x: currentX , y: currentY)
                }else{
                    directionItem = MapDirection(direction: .south, d: "L", x: currentX , y: currentY)
                }
            case .south:
                currentY += 1
                if currentY > pointY{
                    currentY = 0
                }
                let nextWord = gridMap[currentY][currentX]
                if nextWord == "S"{
                    directionItem = MapDirection(direction: .south, d: "S", x: currentX , y: currentY)
                }else if nextWord == "R"{
                    directionItem = MapDirection(direction: .west, d: "R", x: currentX , y: currentY)
                }else{
                    directionItem = MapDirection(direction: .east, d: "L", x: currentX , y: currentY)
                }
            } // switch
            print("directionItem:::\(directionItem)")
            print("visited::\(visited[currentY][currentX][directionItem.direction])")
            if visited[currentY][currentX][directionItem.direction] == true {
                print("1111")
                break}
            
            if directionItem == startDirection {
                cycleCount.append(valueOfDirection.count)
                print("------")
                valueOfDirection.forEach{
                    visited[$0.y][$0.x][$0.direction] = true
                    print("\($0.x),\($0.y),\($0.direction)")
                   
                }
                print("/////////")
                valueOfDirection.removeAll()
                break
            }
            else {
                print(2222)
                valueOfDirection.append(directionItem)
            }
        } // while true
    }
    return cycleCount
}
