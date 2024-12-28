//
//  ListRowView.swift
//  TodoList
//
//  Created by Ricky Mafra Moino on 28/12/24.
//

import SwiftUI

struct ListRowView: View {
    let item: ItemModel
    
    var body: some View {
        HStack {
            Image(systemName: item.isCompleted ? "checkmark.circle" : "circle")
                .foregroundStyle(item.isCompleted ? .green : .red)
            Text(item.title)
            Spacer()
        }
        .font(.title2)
        .padding(.vertical, 8)
    }
}

#Preview {
    let item1 = ItemModel(title: "First Item", isCompleted: false)
    let item2 = ItemModel(title: "Second Item", isCompleted: true)
    
    List {
        ListRowView(item: item1)
        ListRowView(item: item2)
    }
    
}
