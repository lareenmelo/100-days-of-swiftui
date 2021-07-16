//
//  UploadImageView.swift
//  ConferenceApp
//
//  Created by Lareen Melo on 7/14/21.
//

import SwiftUI

struct UploadImageView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var attendees: Attendees
    @State private var showingImagePicker = false
    @State private var showingNoNameAlert = false
    @State private var image: Image?
    @State private var selectedImage: UIImage?
    
    @State private var name = ""
    @State private var handle = ""
    
    
    // Day 78
    private let locationFetcher = LocationFetcher()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Profile photo")) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.secondary)
                            .scaledToFit()
                        
                        if let image = image {
                            image
                                .resizable()
                                .scaledToFit()
                        } else {
                            Text("Tap to select a picture")
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                        
                    }
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        self.showingImagePicker = true
                    }
                    .sheet(isPresented: $showingImagePicker, onDismiss: loadSelectedImage) {
                        ImagePicker(image: self.$selectedImage)
                        
                    }
                }
                
                Section(header: Text("Contact Information")) {
                    TextField("Add a name", text: $name)
                    TextField("Add their twitter handle", text: $handle)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
            }
            .navigationBarTitle("Add a new contact")
            .navigationBarItems(trailing:
                                    Button(action: { self.addContact() },
                                           label: { Text("Add") }
                                    )
            )
            .alert(isPresented: $showingNoNameAlert) {
                Alert(title: Text("Uh-Oh"), message: Text("Please write down a name for this person"), dismissButton: .default(Text("Ok")))
            }
            // Day 78
            .onAppear() {
                self.locationFetcher.start()
            }
        }
    }
    
    func loadSelectedImage() {
        guard let selectedImage = selectedImage else { return }
        image = Image(uiImage: selectedImage)
        
    }
    
    
    func addContact() {
        let twitterHandle = handle.isEmpty ? "N/A" : handle
        
        // name can't be empty
        if name.isEmpty {
            showingNoNameAlert = true
            return
        }
        
        var attendee = Person(name: name, twitterHandle: twitterHandle)
        
        if let selectedImage = selectedImage {
            if let jpegData = selectedImage.jpegData(compressionQuality: 0.8) {
                attendee.setImage(image: jpegData)
            }
        }
        
        // Day 78
        if let location = self.locationFetcher.lastKnownLocation {
            attendee.latitude = location.latitude
            attendee.longitude = location.longitude
            attendee.locationRecorded = true
        }
        else {
            attendee.locationRecorded = false
        }

        self.attendees.attendeesList.append(attendee)
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct UploadImageView_Previews: PreviewProvider {
    static var previews: some View {
        UploadImageView(attendees: Attendees())
    }
}
