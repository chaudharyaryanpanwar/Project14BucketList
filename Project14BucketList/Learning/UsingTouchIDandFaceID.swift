//
//  UsingTouchIDandFaceID.swift
//  Project14BucketList
//
//  Created by Aryan Panwar on 12/08/24.
//

import LocalAuthentication
import SwiftUI

struct UsingTouchIDandFaceID: View {
    
    @State private var isUnlocked = false
    
    var body: some View {
        VStack {
            if isUnlocked {
                Text("Unlocked")
            } else {
                Text("Locked")
            }
        }
        .onAppear(perform: {
            authenticate()
        })
    }
    
    func authenticate() {
        let context = LAContext()
        var error : NSError?
        
//        check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error){
//            if it is possible go ahead and use it
            let reason = "We need to unlock your data."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success , authenticationError in
                
//                authentication has now completed
                if success {
//                    authenticated successfully
                    isUnlocked = true
                } else {
//                    there was a problem
                }
            }
        } else {
//            no biometrics
        }
    }
}

#Preview {
    UsingTouchIDandFaceID()
}
