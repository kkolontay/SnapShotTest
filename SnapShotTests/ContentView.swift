//
//  ContentView.swift
//  SnapShotTests
//
//  Created by Kostiantyn Kolontai on 2025-11-25.
//

import SwiftUI

struct ContentView: View {
  @State var viewModel: ViewStore
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
          Button(action: {
            viewModel.show.toggle()
          }, label: {
            Text("Push me")
          })
        }
        .sheet(isPresented: $viewModel.show, content: {
          SheetContentView(viewModel: viewModel)
        })
        .padding()
    }
}

struct SheetContentView: View {
  @State var viewModel: ViewStore

  var body: some View {
    VStack {
      Text("Hello, world!")
      Button(action: {
        viewModel.show.toggle()
      }, label: {
        Text("push me again")
      })
    }
  }
}

#Preview {
  ContentView(viewModel: ViewStore())
}

@Observable
class ViewStore {
  var show: Bool = false
}
