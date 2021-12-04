//
//  ResortDetailsView.swift
//  SnowSeeker
//
//  Created by He Wu on 2021/12/01.
//

import SwiftUI

struct ResortDetailsView: View {
    let resort: Resort
    
    var body: some View {
        Group {
            Text("Size: \(resort.sizeType)")
                .layoutPriority(1)
            Spacer().frame(height: 0)
            Text("Price: \(resort.priceType)")
                .layoutPriority(1)
        }
    }
}

struct ResortDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ResortDetailsView(resort: .example)
    }
}
