//: [Previous](@previous)

import UIKit


//let urlString = #"https:\/\/www.google.ee\/maps\/place\/39°15'46.2\"S+177°51'52.1\"E\/"#
//let urlString = #"https://www.google.com/maps/place/30°24'08.0"N+130°58'30.0"E/"#
//let urlString = #"https:\/\/en.wikipedia.org\/wiki\/ELA-1"#
let urlString = #"https:\/\/twitter.com\/rocketlab"#


print(urlString)
print(urlString.replacingOccurrences(of: #"\"#, with: ""))

urlString
urlString.removingPercentEncoding


let url = URL(
    string: urlString
        .replacingOccurrences(of: #"\"#, with: "")
        .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
)

//
//print(url?.absoluteURL)
//print(url?.absoluteURL.path)
//print(url!.host)
//print(url!.host!.replacingOccurrences(of: "www.", with: ""))
//print(url!.host!.replacingOccurrences(of: "www.", with: "").replacingOccurrences(of: ".com", with: ""))


/// Strips the leading "sub domain" and trailing "top-level domain"
/// parts (including the ".") from a URL `host` string

print(url!.host!.split(separator: ".").count <= 2)

print(
    url!.host!
        .replacingOccurrences(of: "^(\\w*\\.){1}", with: "", options: .regularExpression)
        .replacingOccurrences(of: "\\.(.*)", with: "", options: .regularExpression)
        .capitalized
)


//: [Next](@next)
