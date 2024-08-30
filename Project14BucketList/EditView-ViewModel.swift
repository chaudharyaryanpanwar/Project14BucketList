//
//  EditView-ViewModel.swift
//  Project14BucketList
//
//  Created by Aryan Panwar on 30/08/24.
//

import Foundation
import SwiftUI

extension EditView {
    @Observable
    class ViewModel {
        var location : Location
        
        enum LoadingState {
            case loading , loaded , failed
        }
        var loadingState: LoadingState = .loading
        
        var name : String
        var description : String
        
        var pages : [Page] = [Page]()
        
        
        init(location: Location) {
            self.location = location
            _name = location.name
            _description = location.description
        }
        
    }
}
