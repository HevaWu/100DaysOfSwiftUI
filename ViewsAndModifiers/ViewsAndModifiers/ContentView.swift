//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by He Wu on 2021/09/05.
//

import SwiftUI

struct GridStack<Content: View>: View {
    let rows: Int
    let cols: Int
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0..<rows) { row in
                HStack {
                    ForEach(0..<cols) { col in
                        self.content(row, col)
                    }
                }
            }
        }
    }
    
    init(rows: Int, cols: Int, content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.cols = cols
        self.content = content
    }
}

struct ContentView: View {

    var body: some View {
        GridStack(rows: 4, cols: 4) { row, col in
            HStack {
                Image(systemName: "\(row * 4 + col).circle")
                Text("R\(row) C\(col)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
