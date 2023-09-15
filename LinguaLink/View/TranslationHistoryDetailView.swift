import SwiftUI

struct TranslationHistoryDetailView: View {
    
    @State var history: TranslationHistory
    @State var translationHistoryViewModel:TranslationHistoryViewModel
    @State private var showAlert = false
    @State private var isEditing = false
    @Environment(\.presentationMode) var presentationMode
    
    @State private var editedDate: Date = Date()
    @State private var editedTopic: String = ""
    @State private var editedType: String = ""
    private var editedCompactDate:String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: editedDate)
    }
    
    var body: some View {
        ScrollView{
            Spacer()
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("Date")
                        .font(.headline)
                    Spacer()
                    if isEditing {
                        DatePicker("", selection: $editedDate, displayedComponents: .date)
                    } else {
                        Text(editedCompactDate)
                    }
                }
                HStack {
                    Text("Topic")
                        .font(.headline)
                    Spacer()
                    if isEditing {
                        TextField("Topic", text: $editedTopic)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    } else {
                        Text(editedTopic)
                    }
                }
                HStack {
                    Text("Type")
                        .font(.headline)
                    Spacer()
                    if isEditing {
                        TextField("Type", text: $editedType)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    } else {
                        Text(editedType)
                    }
                }
                Section(header: Text("Original Text").font(.headline).padding(.top, 5)) {
                    Text(history.originalText)
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Section(header: Text("Translated Text").font(.headline).padding(.top, 5)) {
                    Text(history.translatedText)
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Spacer()
                
                HStack {
                    if isEditing {
                        Button(action: {
                            translationHistoryViewModel.updateTrasnlationHistory(history: history, editedDate: editedDate, editedTopic: editedTopic, editedType: editedType)
//                            translationHistoryViewModel.reloadTranslationHistory()
                            isEditing.toggle() // Exit edit mode
                        }) {
                            Label("Save", systemImage: "square.and.pencil")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(10)
                                .background(Color.green)
                                .cornerRadius(5)
                        }
                    } else {
                        Button(action: {
                            isEditing.toggle() // Enter edit mode
                        }) {
                            Label("Edit", systemImage: "pencil")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(10)
                                .background(Color.blue)
                                .cornerRadius(5)
                        }
                    }
                    
                    Button(action: {
                        showAlert = true
                    }) {
                        Label("Delete", systemImage: "trash")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(10)
                            .background(Color.red)
                            .cornerRadius(5)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Confirm Deletion"),
                        message: Text("Are you sure you want to delete this item?"),
                        primaryButton: .destructive(Text("Delete")) {
                            translationHistoryViewModel.deleteTranslationHistory(history)
                            translationHistoryViewModel.reloadTranslationHistory()
                            presentationMode.wrappedValue.dismiss()
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
            .padding()
            .navigationBarTitle("Translation Details", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                translationHistoryViewModel.reloadTranslationHistory()
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("History")
            })
        }
        .onAppear {
            editedDate = history.date
            editedTopic = history.topic
            editedType = history.type
        }
    }
}

struct TranslationHistoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        @State var demoViewModle = TranslationHistoryViewModel()
        @State var demoTrans = TranslationHistory(date: Date(), type: "", topic: "", originalText: "", translatedText: "")
        NavigationView {
            TranslationHistoryDetailView(history: demoTrans,translationHistoryViewModel: demoViewModle)
        }
    }
}
