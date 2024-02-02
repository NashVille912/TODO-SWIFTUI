//
//  AddView.swift
//  TodoList
//
//  Created by Nacho on 29/01/2024.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    @State var textFieldText: String = ""
    let textFieldBGColor = Color(UIColor.secondarySystemBackground)
    
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    var body: some View {
        ScrollView{
            VStack {
                TextField("Add Something Here...", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(textFieldBGColor)
                    .cornerRadius(10)
                Button(action: saveButtonPressed, label: {
                    Text("Save".uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                }
              )
            }
            .padding(14)
        }
        .navigationTitle("Add an Item 🖊️")
        .alert(isPresented: $showAlert, content: getAlert)
    }
    
    func saveButtonPressed(){
        if textIsApropiated(){
            listViewModel.addItem(title: textFieldText)
            presentationMode.wrappedValue.dismiss()
        }
        
    }
    func textIsApropiated() -> Bool {
        if textFieldText.count < 3 {
            alertTitle = "Your New TODO item must have be at least 3 characters long 😰😨😱"
            showAlert.toggle()
            return false
        }
        return true
    }
    
    func getAlert()-> Alert {
        return Alert(title: Text("\(alertTitle)"))
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddView()
        }.environmentObject(ListViewModel())
        
    }
}
