//
//  PopUpView.swift
//  LinguaLink
//
//  Created by Yangru Guo on 12/9/2023.
//

import SwiftUI

struct PopUpView: View {
    
    @Binding var isPopUpPresented: Bool
    var popUpViewModel = PopUpViewModel()
    @State var date:Date = Date()
    @State var topic:String = ""
    @State var type:String = ""
    @State var originalText:String
    @State var translatedText:String
    

    var body: some View {
        NavigationView {
            List {
                Section() {
                    HStack{
                        Image(systemName: "calendar")
                        DatePicker("", selection: $date, displayedComponents: .date)
                    }
                }
                
                Section(header: Text("Type")) {
                    TextField("Enter type", text: $type)
                }

                Section(header: Text("Topic")) {
                    TextField("Enter topic", text: $topic)
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
                    isPopUpPresented = false;
                },
                trailing: Button("Save") {
                    // Handle saving the data here
                    popUpViewModel.saveTranslationHistory(date: date, topic: topic, type: type, originalText: originalText, translatedText: translatedText)
                    isPopUpPresented = false;
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
    @State static var isPresented = false
    static var previews: some View {
        PopUpView(isPopUpPresented: $isPresented, originalText: "",translatedText: "")
    }
}
