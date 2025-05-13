//
//  ContentView.swift
//  WristList
//
//  Created by Justin on 5/13/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    @State private var text = ""
    @State private var shouldShowAlert = false
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    Text(item.text)
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button {
                        shouldShowAlert = true
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .alert("Add New Item", isPresented: $shouldShowAlert) {
                TextField("Enter text", text: $text)
                Button("Add") {
                    addItem(with: text)
                }
                .disabled(text.isEmpty)
                
                Button("Cancel", role: .cancel) {}
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem(with text: String) {
        withAnimation {
            let newItem = Item(text: text, isDone: false)
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
