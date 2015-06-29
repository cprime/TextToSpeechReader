//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

println("Hello, World")

var text1 = "where you don&#x2019;t where you don&#x2019;t"

var regex = NSRegularExpression(pattern: "&#[xX][a-fA-F0-9]+;", options: .CaseInsensitive, error: nil)
while let result = regex!.firstMatchInString(text1, options: NSMatchingOptions.allZeros, range: NSRange(location: 0, length: count(text1))) {
    var matchingRange = result.rangeAtIndex(0)
    break;
}
