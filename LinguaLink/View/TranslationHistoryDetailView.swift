import SwiftUI

struct TranslationHistoryDetailView: View {
    
    @State var history: TranslationHistory
    @State var translationHistoryViewModel:TranslationHistoryViewModel
    @State private var showAlert = false
    @Binding var isDetailViewPresented: Bool
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView{
            Spacer()
            VStack(alignment: .leading, spacing: 16) {
                HStack{
                    Text("Date")
                        .font(.headline)
                    Spacer()
                    Text(history.compactDate)
                }
                HStack{
                    Text("Topic")
                        .font(.headline)
                    Spacer()
                    Text(history.topic)
                }
                HStack{
                    Text("Type")
                        .font(.headline)
                    Spacer()
                    Text(history.type)
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
                
                Button(action: {
                    showAlert = true
                }) {
                    Label("Delete", systemImage: "trash")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Confirm Deletion"),
                        message: Text("Are you sure you want to delete this item?"),
                        primaryButton: .destructive(Text("Delete")) {
                            translationHistoryViewModel.deleteTranslationHistory(history)
                            translationHistoryViewModel.updateTranslationHistory()
                            presentationMode.wrappedValue.dismiss()
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
            .padding()
            .navigationBarTitle("Translation Details", displayMode: .inline)
        }
    }
}

struct TranslationHistoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        @State var demo = true
        @State var demoViewModle = TranslationHistoryViewModel()
        NavigationView {
            TranslationHistoryDetailView(history: translationHistoryArray[0],translationHistoryViewModel: demoViewModle, isDetailViewPresented: $demo)
        }
    }
}
