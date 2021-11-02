//
//  CenterCircleView.swift
//  FriendsContact
//
//  Created by He Wu on 2021/11/02.
//

import SwiftUI

struct CenterCircleView: View {
    var body: some View {
        Circle()
            .fill(Color.orange)
            .opacity(0.3)
            .frame(width: 20, height: 20)
    }
}

struct CenterCircleView_Previews: PreviewProvider {
    static var previews: some View {
        CenterCircleView()
    }
}
