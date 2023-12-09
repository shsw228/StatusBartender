//
//  ContentView.swift
//  StatusBartender
//  
//  Created by shsw228 on 2023/12/09
//


import SwiftUI
import SimplyCoreAudio

struct ContentView: View {
    let simplyCA = SimplyCoreAudio().allOutputDevices

    var body: some View {
        LazyVStack(alignment: .leading) {
            ForEach(simplyCA, id: \.self) { item in
                Text(item.name)
            }
        }.padding()
    }
}
#Preview {
    ContentView()
}
