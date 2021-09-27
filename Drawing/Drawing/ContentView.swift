//
//  ContentView.swift
//  Drawing
//
//  Created by He Wu on 2021/09/25.
//

import SwiftUI

struct Checkerboard: Shape {
    var rows: Int
    var cols: Int
    
    public var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(Double(rows), Double(cols))
        }
        set {
            self.rows = Int(newValue.first)
            self.cols = Int(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let rowSize = rect.height / CGFloat(rows)
        let colSize = rect.width / CGFloat(cols)
        
        for r in 0..<rows {
            for c in 0..<cols {
                if (r + c).isMultiple(of: 2) {
                    let startX = colSize * CGFloat(c)
                    let startY = rowSize * CGFloat(r)
                    
                    let rect = CGRect(x: startX, y: startY, width: colSize, height: rowSize)
                    path.addRect(rect)
                }
            }
        }
        
        return path
    }
}

struct ContentView: View {
    @State private var rows = 4
    @State private var cols = 4
    
    var body: some View {
        Checkerboard(rows: rows, cols: cols)
            .onTapGesture {
                withAnimation(.linear(duration: 3)) {
                    self.rows = 8
                    self.cols = 16
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
