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
            print("currency not accepted")
        }
    }
    
    func convert(_ c: String) -> Money {
        let exchangeRate = ["GBP": 0.5/2, "EUR": 1.5/2, "CAN": 1.25/4]
        var USDamount = Double(amount)
        if (self.currency != "USD") {
            USDamount = Double(self.amount) / exchangeRate[self.currency]!
        }
        let newAmount = Int(round(USDamount * exchangeRate[c]!))
        return Money(amount: newAmount, currency: c)
    }
    
    func add(_ m: Money) -> Money {
        let exchangeRate = ["GBP": 0.5/2, "EUR": 1.5/2, "CAN": 1.25/4]
        var CUSDamount = Double(self.amount)
        if (self.currency != "USD") {
            CUSDamount = Double(self.amount) / exchangeRate[self.currency]!
        }
        var NUSDamount = Double(m.amount)
        if (m.currency != "USD") {
            NUSDamount = Double(m.amount) / exchangeRate[m.currency]!
        }
        let newAmount = Int(round((CUSDamount + NUSDamount) * exchangeRate[m.currency]!))
        return Money(amount: newAmount, currency: m.currency)
    }
    
    func subtract(_ m: Money) -> Money {
        let exchangeRate = ["GBP": 0.5/2, "EUR": 1.5/2, "CAN": 1.25/4]
        var CUSDamount = Double(self.amount)
        if (self.currency != "USD") {
            CUSDamount = Double(self.amount) / exchangeRate[self.currency]!
        }
        var NUSDamount = Double(m.amount)
        if (m.currency != "USD") {
            NUSDamount = Double(m.amount) / exchangeRate[m.currency]!
        }
        let newAmount = Int(round((CUSDamount - NUSDamount) * exchangeRate[m.currency]!))
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
                type = JobType.Hourly(amount * p)
            case .Salary(let amount):
                type = JobType.Salary(amount * UInt(round(p)))
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
        var job: Job?
        var spouse: Person?
        
        init(firstName f: String, lastName l: String, age a: Int) {
            firstName = f
            lastName = l
            age = a
        }
        
        func toString() -> String {
            if spouse !== nil && job !== nil {
                return "[Person: firstName:\(firstName) lastName:\(lastName) job:\(job!.title) spouse:\(spouse!.firstName)]"
            } else if spouse !== nil && job === nil {
                return "[Person: firstName:\(firstName) lastName:\(lastName) job:nil spouse:\(spouse!.firstName)]"
            } else if spouse === nil && job !== nil {
                return "[Person: firstName:\(firstName) lastName:\(lastName) job:\(job!.title) spouse:nil]"
            } else {
                return "[Person: firstName:\(firstName) lastName:\(lastName) job:nil spouse:nil]"
            }
        }
}

////////////////////////////////////
// Family
//
public class Family {
}
