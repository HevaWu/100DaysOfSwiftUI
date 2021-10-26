//
//  CenterCircleView.swift
//  BucketList
//
//  Created by He Wu on 2021/10/26.
//

import SwiftUI

struct CenterCircleView: View {
    var body: some View {
        Circle()
            .fill(Color.blue)
            .opacity(0.3)
            .frame(width: 32, height: 32)
    }
}

struct CenterCircleView_Previews: PreviewProvider {
    static var previews: some View {
        CenterCircleView()
    }
}
