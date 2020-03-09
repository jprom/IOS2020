import UIKit


// createArrayWithContent(string: “Dog”, number: 4) -> [“Dog”, “Dog”, “Dog”, “Dog”]

func createArrayWithContent (word: String, qty: NSInteger) -> Array<String> {
        var array = [String]()
        array.append(contentsOf: repeatElement(word, count: qty))
        return array
}

createArrayWithContent(word: "Dog", qty: 4)

//2

func printDifferentNumbers(number: NSInteger) -> Void {
    for n in 1...number{
        if(n % 2 == 0){
            print("\(n) es par")
        }else{
            print("\(n) es impar")
        }
    }
}

printDifferentNumbers(number: 3)

//3

func searchTheLongestString(stringOne: String, stringTwo: String) -> String{
    var longestString : String
    if(stringOne.count > stringTwo.count){
        longestString = stringOne
    }else{
        longestString = stringTwo
    }
    return longestString
}

 searchTheLongestString(stringOne: "dog", stringTwo: "Hello")

//4

func isPerfectSq(n: Double) -> Bool {
    var flag : Bool = false
    var x : NSInteger = Int(n.squareRoot())
    
    if(x*x == Int(n)){
        flag = true
    }
    return flag
}

func isFibbonnacciNumber(n: Double) -> Bool {
    var flag : Bool = false
    if(isPerfectSq(n: 5*n*n + 4) || isPerfectSq(n: 5*n*n - 4)){
        flag = true
        print ("el valor \(n) pertenece a la serie Fibonnacci")
    }else{
        print ("el valor \(n) NO pertenece a la serie Fibonnacci")
    }
    return flag
}

isFibbonnacciNumber(n: 5.0)
