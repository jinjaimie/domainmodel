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
}

////////////////////////////////////
// Person
//
public class Person {
}

////////////////////////////////////
// Family
//
public class Family {
}
