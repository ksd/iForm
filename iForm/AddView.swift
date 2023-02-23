//
//  AddView.swift
//  iForm
//
//  Created by ksd on 17/02/2023.
//

import SwiftUI

struct AddView: View {
    
    enum Gender: String, CaseIterable, Identifiable {
        case male
        case female
        case other
        var id: String {
            self.rawValue
        }
    }
    
    enum Language: String, CaseIterable, Identifiable {
        case english
        case french
        case spanish
        case japanese
        case other
        var id: String {
            self.rawValue
        }
    }
    
    @State var name = ""
    @State var password = ""
    @State var gender = Gender.female
    @State var birthDate = Date()
    @State var language = Language.english
    @State var isAgreed = true
    @State var isShowingAlert = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            HStack{
            Button {
                dismiss()
            } label: {
                Text("Annuller").padding(.all)
            }
            Spacer()
        }
            Form {
                DisclosureGroup {
                        TextField("Username", text: $name)
                        SecureField("Password", text: $password)
                } label: {
                    Label("Credentials", systemImage: "person")
                }

               
                Section(header: Text("User Info")) {
                    Picker("Gender", selection: $gender) {
                        ForEach(Gender.allCases) { gender in
                            Text(gender.rawValue.capitalized).tag(gender)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    DatePicker("Date of birth",
                               selection: $birthDate,
                               displayedComponents: [.date])
                    Picker("Language", selection: $language) {
                        ForEach(Language.allCases) { language in
                            Text(language.rawValue.capitalized)
                                .tag(language)
                        }
                    }
                }
                Section {
                    Toggle(isOn: $isAgreed) {
                        Text("Agree to our")
                        Link("terms of Service",
                             destination: URL(string:"https://example.com/TOS.html")!)
                    }
                    
                    Button {
                        isShowingAlert = true
                    } label: {
                        HStack {
                            Spacer()
                            Text("Save")
                            Spacer()
                        }
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.accentColor)
                    .cornerRadius(8)
                    .alert(isPresented: $isShowingAlert) {
                        Alert(title: Text("Form Submitted"),
                              message: Text("Thanks \(name)\nWe will be in contact soon!"),
                              dismissButton: .default(Text("OK")){dismiss()})
                    }
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
