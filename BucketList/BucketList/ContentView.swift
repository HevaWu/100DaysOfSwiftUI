//
//  ContentView.swift
//  BucketList
//
//  Created by He Wu on 2021/10/19.
//

import SwiftUI

struct ContentView: View {
    func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    var body: some View {
        Text("Hello World")
            .onTapGesture {
                let str = "Test Message"
                let url = getDocumentDirectory().appendingPathComponent("message.txt")
                
                do {
                    try str.write(
                        to: url,
                        atomically: true,
                        encoding: .utf8
                    )
                    let input = try String(contentsOf: url)
                    print(input)
                } catch {
                    print(error.localizedDescription)
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
