//
//  AddItemView.swift
//  TodoList
//
//  Created by Ricky Mafra Moino on 28/12/24.
//

import SwiftUI

struct AddItemView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(ListViewModel.self) private var listViewModel
    @State var textFieldText: String = ""
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    var body: some View {
        VStack {
            TextField("Add new item...", text: $textFieldText)
                .frame(height: 55)
                .padding(.leading)
                .background(Color(UIColor.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 10))

            Button {
                saveButtonPressed()
            } label: {
                Text("Save")
                    .frame(height: 35)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .padding(.vertical, 6)

            Spacer()
        }
        .navigationTitle("Add item ✏️")
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle))
        }
    }
    
    func saveButtonPressed() {
        if (isItemValid()) {
            listViewModel.addItem(title: textFieldText)
            dismiss()
        }
    }
    
    func isItemValid() -> Bool {
        if textFieldText.count < 3 {
            alertTitle = "Your new item must have at least 3 characters. 🤷🏻‍♂️"
            showAlert.toggle()
            return false
        }
        return true
    }
}

#Preview {
    @Previewable @State var listViewModel = ListViewModel()
    NavigationView {
        AddItemView()
            .environment(listViewModel)
    }
}
