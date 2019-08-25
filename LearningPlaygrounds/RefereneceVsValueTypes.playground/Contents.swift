import UIKit

// let's start with a value type
struct MyValueType {
    var name: String
    var assignment: String
    var grade: Int
}

// the same implented now as a class (reference type)
class MyReferenceType {
    var name: String
    var assignment: String
    var grade: Int
    
    // reference type needs initialitzation
    init (name: String, assignment: String, grade: Int) {
        self.name = name
        self.assignment = assignment
        self.grade = grade
    }
}

// creating an instance of the value type
var val = MyValueType(name: "Jon", assignment: "Math Test 1 ", grade: 90)

// creating an instance of the reference type
var ref = MyReferenceType(name: "Jon", assignment: "Math Test 1", grade: 90)

// creating functions that change the grades for both instances
func extraReferenceType(ref: MyReferenceType, extraCredit: Int) {
    ref.grade += extraCredit
}

func extraValueType(val: MyValueType, extraCredit: Int) {
    var val = val
    val.grade += extraCredit
}

// What happens when use this function on reference type
extraReferenceType(ref: ref, extraCredit: 5)
print("Reference: \(ref.name) - \(ref.grade)")

// What happens when use this function on value type
extraValueType(val: val, extraCredit: 5)
print("Value: \(val.name) - \(val.grade)")

// function to assing the grade to students using reference type
func getGradeForAssignment (assignment: MyReferenceType) {
    // Code to get grade from DB
    // Random code here to illustrate issue with reference type
    let num = Int(arc4random_uniform(20) + 80)
    assignment.grade = num
    print("Grade for \(assignment.name) is \(num)")
}

// array to store the mathGrades for the students
var mathGrades = [MyReferenceType]()
// array with the list of students we want to assign the mathGrades
var students = ["Jon", "Kim", "Kailey", "Kara"]
// MyReferenceType instance to do the assignment of students name and pass as parameter to the function getGradeForAssignment
var mathAssignment = MyReferenceType(name: "", assignment: "Math Assignment", grade: 0)

// Loop that assign the name of the students array to the mathAssingment instance, call the method passing the actual mathAssignment as its parameter and adds it to the mathGrades array
for student in students {
    mathAssignment.name = student
    getGradeForAssignment(assignment: mathAssignment)
    mathGrades.append(mathAssignment)
}

// Loop to print the array elements in mathGrades
for assignment in mathGrades {
    print("\(assignment.name): grade \(assignment.grade)")
}
// just a test to confirm that all the elements are equal to the last: Kara...
print("\(mathGrades[1].name): grade \(mathGrades[1].grade)")

// function to assing the grade to students using reference type
func getGradeForAssignmentInOut (assignment: inout MyValueType) {
    // Code to get grade from DB
    // Random code here this time the new value is passed back out of the function to replace the original
    let num = Int(arc4random_uniform(20) + 80)
    assignment.grade = num
    print("Grade for \(assignment.name) is \(num)")
}

var mathGradesValue = [MyValueType]()
// var students is already created and will use it again
var mathAssignmentValue = MyValueType(name: "", assignment: "Math Assignment", grade: 0)

// the value type version of previous loop, notice the & to mark that we are passing a reference to de value type and want the changes of the function to be reflected back to the original instance
for student in students {
    mathAssignmentValue.name = student
    getGradeForAssignmentInOut(assignment: &mathAssignmentValue)
    mathGradesValue.append(mathAssignmentValue)
}

// Loop to print the array elements in mathGradesValue
for assignment in mathGradesValue {
    print("\(assignment.name): grade \(assignment.grade)")
}
