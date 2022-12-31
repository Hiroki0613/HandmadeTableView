import UIKit

//protocol Caluculator {
//    func calculate(a: Int, b: Int) -> Int
//}
//
//struct Addition: Caluculator {
//    func calculate(a: Int, b: Int) -> Int {
//        a + b
//    }
//}
//
//struct Subtraction: Caluculator {
//    func calculate(a: Int, b: Int) -> Int {
//        a - b
//    }
//}
//
//var caluculator: Caluculator = Addition()
//caluculator.calculate(a: 10, b: 20)
//caluculator = Subtraction()
//caluculator.calculate(a: 100, b: 1)


//class AdditionMessageMaker {
//    func makeMessage(a: Int, b: Int) -> String {
//        return "\(a)と\(b)を足し算すると、結果は\(a + b)です。"
//    }
//}
//
//AdditionMessageMaker().makeMessage(a: 10, b: 20)
//
//protocol Calculator: AnyObject {
//    var name: String { get }
//    func calculate(a: Int, b: Int) -> Int
//}
//
//class MessageMaker {
//    weak var calculator: Calculator?
//    func makeMessage(a: Int, b: Int) -> String {
//        if let calculator = calculator {
//            let result = calculator.calculate(a: a, b: b)
//            return "\(a)と\(b)を\(calculator.name)すると、結果は\(result)です。"
//        } else {
//            return "calculatorが設定されていません"
//        }
//    }
//}
//
//class AdditionCalculator: Calculator {
//    let name = "たしざん"
//    func calculate(a: Int, b: Int) -> Int {
//        return a + b
//    }
//}
//
//let maker = MessageMaker()
//maker.makeMessage(a: 10, b: 20)
//
//let additionCalculator = AdditionCalculator()
//maker.calculator = additionCalculator
//maker.makeMessage(a: 10, b: 20)
//
//class SubtractionCalculator: Calculator {
//    let name = "ひきざん"
//    func calculate(a: Int, b: Int) -> Int {
//        return a - b
//    }
//}
//
//let subtractionCalculator = SubtractionCalculator()
//maker.calculator = subtractionCalculator
//maker.makeMessage(a: 10, b: 20)

protocol ItemListDataSource: AnyObject {
    func numberOfItems() -> Int
    func stringForRowAt(index: Int) -> String
}

class ItemListPrinter {
    weak var dataSource: ItemListDataSource?
    func reload() {
        guard let dataSource = dataSource else { return }
        for i in 0..<dataSource.numberOfItems() {
            let text = dataSource.stringForRowAt(index: i)
            print("・\(text)")
        }
    }
}

class FruitsDataSource: ItemListDataSource {
    func numberOfItems() -> Int {
        return 3
    }

    func stringForRowAt(index: Int) -> String {
        switch index {
        case 0:
            return "りんご"
        case 1:
            return "みかん"
        default:
            return "バナナ"
        }
    }
}

class UsersDataSource: ItemListDataSource {
    private let users: [String] = ["さとう", "すずき", "たなか"]

    func numberOfItems() -> Int {
        return users.count
    }
    func stringForRowAt(index: Int) -> String {
        return users[index]
    }
}

//let itemListPrinter = ItemListPrinter()
//let fruitsDataSource = FruitsDataSource()
//itemListPrinter.dataSource = fruitsDataSource
//itemListPrinter.reload()
//print("--------------------------")
//let userDataSource = UsersDataSource()
//itemListPrinter.dataSource = userDataSource
//itemListPrinter.reload()

class ViewControllerOne: UIViewController {
    private let itemListPrinter = ItemListPrinter()
    private let fruitsDataSource = FruitsDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemListPrinter.dataSource = fruitsDataSource
        print("例１")
        itemListPrinter.reload()
    }
}

let viewControllerOne = ViewControllerOne()
viewControllerOne.viewDidLoad()

class ViewControllerTwo: UIViewController, ItemListDataSource {
    private let fruits: [String] = ["松", "竹", "梅"]
    func numberOfItems() -> Int {
        return fruits.count
    }
    func stringForRowAt(index: Int) -> String {
        return fruits[index]
    }
    private let itemListPrinter = ItemListPrinter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemListPrinter.dataSource = self
        print("例２")
        itemListPrinter.reload()
    }
}

let viewControllerTwo = ViewControllerTwo()
viewControllerTwo.viewDidLoad()
