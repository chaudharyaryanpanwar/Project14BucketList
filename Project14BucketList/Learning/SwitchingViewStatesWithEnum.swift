//
//  SwitchingViewStatesWithEnum.swift
//  Project14BucketList
//
//  Created by Aryan Panwar on 12/08/24.
//

import SwiftUI

enum LoadingState {
    case loading, success, failed
}

struct SwitchingViewStatesWithEnum: View {
    
    @State private var loadingState = LoadingState.loading
    
    var body: some View {
        if loadingState == .loading {
            LoadingView()
        } else if loadingState == .success{
            SuccessView()
        } else if loadingState == .failed {
            FailedView()
        }
    }
}

struct LoadingView : View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView : View {
    var body: some View {
        Text("Success!")
    }
}

struct FailedView : View {
    var body: some View {
        Text("Failed.")
    }
}
    
#Preview {
    SwitchingViewStatesWithEnum()
}
