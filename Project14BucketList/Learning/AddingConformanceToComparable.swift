//
//  AddingConformanceToComparable.swift
//  Project14BucketList
//
//  Created by Aryan Panwar on 11/08/24.
//

import SwiftUI

struct AddingConformanceToComparable: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

//struct ContentView1 : View {
//    let values = [1 , 5 , 3, 6 , 2, 9].sorted()
//    
//    var body : some View {
//        List(values , id : \.self){
//            Text(String($0))
//        }
//    }
//}

//struct User : Identifiable {
//    let id = UUID()
//    var firstName : String
//    var lastName : String
//}

struct User : Identifiable , Comparable {
    let id = UUID()
    var firstName : String
    var lastName : String
    
    static func <(lhs : User , rhs : User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}


struct ContentView1 : View {
//    let users  = [
//    User(firstName: "Arnold", lastName: "Rimmer") ,
//    User(firstName: "Kristine", lastName: "Kochanski") ,
//    User(firstName: "David", lastName: "Lister")
//    ].sorted {
//        $0.lastName < $1.lastName
//    }
    
    let users  = [
    User(firstName: "Arnold", lastName: "Rimmer") ,
    User(firstName: "Kristine", lastName: "Kochanski") ,
    User(firstName: "David", lastName: "Lister")
    ].sorted()
    
    var body : some View {
        List(users) { user in
            Text("\(user.firstName), \(user.lastName)")
        }
    }
}

#Preview {
//    AddingConformanceToComparable()
//    ContentView1()
    ContentView1()
}
