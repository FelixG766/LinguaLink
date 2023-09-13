//
//  PopUpView.swift
//  LinguaLink
//
//  Created by Yan Hua on 12/9/2023.
//

import SwiftUI

struct PopUpView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var popUpViewModel: PopUpViewModel
    @State var originalText:String
    @State var translatedText:String
    

    var body: some View {
        NavigationView {
            List {
                Section() {
                    HStack{
                        Image(systemName: "calendar")
                        DatePicker("", selection: $popUpViewModel.selectedDate, displayedComponents: .date)
                    }
                }
                
                Section(header: Text("Type")) {
                    TextField("Enter type", text: $popUpViewModel.type)
                }

                Section(header: Text("Topic")) {
                    TextField("Enter topic", text: $popUpViewModel.topic)
                }

                Section(header: Text("Original Text")) {
                    Text(originalText)
                        .font(.body)
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                Section(header: Text("Translated Text")) {
                    Text(translatedText)
                        .font(.body)
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .navigationBarTitle("Save Translation")
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    // Handle saving the data here
                    
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
        .onTapGesture {
            // Dismiss the keyboard when tapped outside of the TextField
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}

struct PopUpView_Previews: PreviewProvider {
    static var previews: some View {
        PopUpView(popUpViewModel: PopUpViewModel(),originalText: "",translatedText: "")
    }
}
