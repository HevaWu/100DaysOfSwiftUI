//
//  ContentView.swift
//  Drawing
//
//  Created by He Wu on 2021/09/25.
//

import SwiftUI

struct Arrow: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let leftRectH: CGFloat = rect.height / CGFloat(3)
        let leftRect = CGRect(x: 0, y: Int(rect.minY + leftRectH), width: Int(rect.width/2), height: Int(leftRectH))
        path.addRect(leftRect)
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

struct ContentView: View {
    @State private var thickness: CGFloat = 10
    
    var body: some View {
        VStack {
            Spacer(minLength: 30)
            
            Arrow()
                .stroke(Color.blue, style: StrokeStyle(lineWidth: thickness, lineCap: .round, lineJoin: .round))
                .frame(width: 300, height: 200)
            
            Spacer()
                        
            Text("Thickness: \(thickness, specifier: "%.2f")")
            Slider(value: $thickness, in: 10...100)
        }
        .padding([.horizontal, .vertical])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
