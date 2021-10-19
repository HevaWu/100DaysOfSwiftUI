//
//  ContentView.swift
//  BucketList
//
//  Created by He Wu on 2021/10/19.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        Text("Loading")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed")
    }
}

struct ContentView: View {
    enum LoadingState {
        case loading
        case success
        case failed
    }
    
    var loadingState = LoadingState.loading
    
    var body: some View {
        Group {
            switch loadingState {
            case .loading:
                LoadingView()
            case .success:
                SuccessView()
            case .failed:
                FailedView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
