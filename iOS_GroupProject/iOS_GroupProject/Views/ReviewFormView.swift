//
//  ReviewSheetView.swift
//  iOS_GroupProject
//
//  Created by Bùi Thiên on 22/09/2023.
//

import SwiftUI

struct ReviewFormView: View {
    @Binding var isFormPresented: Bool
    @State private var reviewContent = ""
    @State private var rating = 1 // Default rating

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Review")) {
                    TextEditor(text: $reviewContent)
                        .frame(height: 150)
                }

                Section(header: Text("Rating")) {
                    Picker("Rating", selection: $rating) {
                        ForEach(1..<6, id: \.self) { number in
                            Text("\(number)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section {
                    Button(action: {
                        // Add logic to submit the review and save it to your data store (e.g., Firestore)
                        // After submitting, you can dismiss the sheet
                        isFormPresented = false
                    }) {
                        Text("Submit Review")
                    }
                }
            }
            .navigationTitle("Write a Review")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        // Close the form without submitting
                        isFormPresented = false
                    }
                }
            }
        }
    }
}

struct ReviewFormView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewFormView(isFormPresented: .constant(true))
    }
}
