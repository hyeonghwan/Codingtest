import Foundation
//반복문
func gcd(_ n: Int, _ m: Int) {

    var min = 0
    var g = 0
    n > m ? (min = m) : (min = n)

    for i in (1...min).reversed() {
        if n % i == 0 && m % i == 0{
            g = i
            break
        }
    }
    print(g)
}

//재귀활용 최대공약수
func gcd1(_ n: Int, _ m: Int) -> Int {
    if (m == 0) {
        return n
    }else {return gcd1(m, n%m)}
}


// 반복문 2
func gcd2(_ n: Int, _ m: Int) -> Int {
    var max = 0
    var min = 0
    (n > m) ? (min = m) : (min = n)
    
    while (min > 0) {
        if (n % min == 0 && m % min == 0) {
            max = min
            break
        }
            min -= 1
    }
    return max
}
