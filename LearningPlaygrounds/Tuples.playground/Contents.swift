import UIKit

// TUPLES: finite, ordered, comma-separated list of elements.
// Example of unnamed tuple
let mathGrade1 = ("Jon", 100)
let (name, score) = mathGrade1
print("\(name) - \(score)")

// retrieving values from a named tuple is easier than from a unnamed one
let mathGrade2 = (name: "Jon", grade: 100)
print("\(mathGrade2.name) - \(mathGrade2.grade)")

// Using tuples to return multiple values from a function
func calculateTip(billAmount: Double, tipPercent: Double) ->
    (tipAmount: Double, totalAmount: Double) {
        let tip = billAmount * (tipPercent/100)
        let total = billAmount + tip
        return (tipAmount: tip, totalAmount: total)
}

var tip = calculateTip(billAmount: 31.98, tipPercent: 20)
print("\(tip.tipAmount) - \(tip.totalAmount)")

// how to asign an alias to a tuple
typealias myTuple = (tipAmount: Double, totalAmount: Double)
