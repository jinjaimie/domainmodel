import Foundation

struct DomainModel {
    var text = "Hello, World!"
        // Leave this here; this value is also tested in the tests,
        // and serves to make sure that everything is working correctly
        // in the testing harness and framework.
}

////////////////////////////////////
// Money
//
public struct Money {
    var amount: Int
    var currency: String
    
    init(amount a: Int, currency c: String) {
        let acceptedCurrency = ["USD", "GBP", "EUR", "CAN"]
        if (acceptedCurrency.contains(c)) {
            amount = a
            currency = c
        } else {
            amount = 0
            currency = "USD"
            print("currency not accepted or amount not ")
        }
    }
    
    func convert(_ c: String) -> Money {
        let exchangeRate = ["GBP": 0.5, "EUR": 1.5, "CAN": 1.25, "USD": 1.0]
        let newAmount = Double(self.amount) / exchangeRate[self.currency]! * exchangeRate[c]!
        return Money(amount: Int(round(newAmount)), currency: c)
    }
    
    func add(_ m: Money) -> Money {
        let currAmount = convert(m.currency)
        let newAmount = currAmount.amount + m.amount
        return Money(amount: newAmount, currency: m.currency)
    }
    
    func subtract(_ m: Money) -> Money {
        let currAmount = convert(m.currency)
        let newAmount = currAmount.amount - m.amount
        return Money(amount: newAmount, currency: m.currency)

    }
}

////////////////////////////////////
// Job
//
public class Job {
    public enum JobType {
        case Hourly(Double)
        case Salary(UInt)
    }
    var title: String
        var type: JobType
        
        init(title t: String, type ty: JobType) {
            title = t
            type = ty
        }
        
        func calculateIncome(_ t: Int) -> Int {
            switch type {
            case .Hourly(let amount):
                return Int(round(amount * Double(t)))
            case .Salary(let amount):
                return Int(amount)
            }
        }
        
        func raise(byPercent p: Double) {
            switch type {
            case .Hourly(let amount):
                type = JobType.Hourly(amount + (amount * p))
            case .Salary(let amount):
                type = JobType.Salary(amount + UInt(round(Double(amount) * p)))
            }
        }
        
        func raise(byAmount a: Double) {
            switch type {
            case .Hourly(let amount):
                type = JobType.Hourly(amount + a)
            case .Salary(let amount):
                type = JobType.Salary(amount + UInt(round(a)))
            }
        }
        
        func raise(byAmount a: Int) {
            switch type {
            case .Hourly(let amount):
                type = JobType.Hourly(amount + Double(a))
            case .Salary(let amount):
                type = JobType.Salary(amount + UInt(a))
            }
        }
}

////////////////////////////////////
// Person
//
public class Person {
    var firstName: String
    var lastName: String
    var age: Int
    var _job : Job? = nil
          open var job : Job? {
            get { return self._job }
            set(value) {
              if self.age > 20 {
                self._job = value
              }
            }
          }
    var _spouse: Person?  = nil
    open var spouse : Person? {
        get { return self._spouse }
      set(value) {
        if self.age > 20 {
          self._spouse = value
        }
      }
    }
        
        init(firstName f: String = "", lastName l: String = "", age a: Int) {
            firstName = f
            lastName = l
            age = a
        }
        
        func toString() -> String {
            if spouse !== nil && job !== nil {
                return "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(job!.title) spouse:\(spouse!.firstName)]"
            } else if spouse !== nil && job === nil {
                return "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:nil spouse:\(spouse!.firstName)]"
            } else if spouse === nil && job !== nil {
                return "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(job!.title) spouse:nil]"
            } else {
                return "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:nil spouse:nil]"
            }
        }
}

////////////////////////////////////
// Family
//
public class Family {
    var members: [Person] = []
        
        init(spouse1: Person, spouse2: Person) {
            if (spouse1.spouse === nil && spouse2.spouse === nil) {
                spouse1.spouse = spouse2
                spouse2.spouse = spouse1
                members = [spouse1, spouse2]
            } else {
                print("someone is already married!")
            }
        }
        
        func haveChild(_ c: Person) -> Bool {
            if (members[0].age > 21 || members[1].age > 21) {
                members.append(c)
                return true
            }
            return false
        }
        
        func householdIncome() -> Int {
            var totalIncome = 0
            for m in members {
                if (m.job !== nil) {
                    totalIncome += m.job!.calculateIncome(2000);
                }
            }
            return totalIncome
        }
}
