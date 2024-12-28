//
//  ListView.swift
//  TodoList
//
//  Created by Ricky Mafra Moino on 28/12/24.
//

import SwiftUI

struct ListView: View {
    @Environment(ListViewModel.self) private var listViewModel
    @State private var searchText: String = ""
    private var searchedItems: [ItemModel] {
        let items = listViewModel.items
        if searchText.isEmpty {
            return items
        }
        return items.filter { $0.title.lowercased().contains(searchText.lowercased()) }
    }
    private let isLandscape: Bool = UIScreen.main.bounds.width > UIScreen.main.bounds.height
    
    var body: some View {
        List {
            ForEach(searchedItems) { item in
                ListRowView(item: item)
                    .onTapGesture {
                        withAnimation(.linear) {
                            listViewModel.updateIsCompleted(item: item)
                        }
                    }
            }
            .onDelete(perform: listViewModel.deleteItem)
            .onMove(perform: listViewModel.moveItem)
        }
        .frame(maxWidth: isLandscape ? UIScreen.main.bounds.width - 150 : .infinity)
        .listStyle(.plain)
        .navigationTitle("Todo List 📝")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                EditButton()
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink("Add") {
                    AddItemView()
                        .environment(listViewModel)
                }
            }
        }
        .searchable(text: $searchText, prompt: "Search items")
        .overlay {
            if listViewModel.isLoading {
                ProgressView()
            } else if searchText.isEmpty && searchedItems.isEmpty {
                ContentUnavailableView {
                    Label("0 items found", systemImage: "tray.fill")
                } description: {
                    Text("Start by adding items")
                } actions: {
                    NavigationLink("Add new item") {
                        AddItemView()
                            .environment(listViewModel)
                    }
                }
            } else if searchText.count > 1 && searchedItems.isEmpty {
                ContentUnavailableView.search(text: searchText)
            }
        }
    }
}

#Preview {
    @Previewable @State var listViewModel = ListViewModel()
    
    NavigationStack {
        ListView()
            .environment(listViewModel)
    }
}
