//
//  PersonDetailView.swift
//  ConferenceApp
//
//  Created by Lareen Melo on 7/14/21.
//

import SwiftUI

struct PersonDetailView: View {
    var attendee: Person
    
    var body: some View {
        getImage(for: attendee)
            .resizable()
            .scaledToFit()
            // for placeholders
            .foregroundColor(Color.gray)
            .navigationBarTitle(Text(attendee.name), displayMode: .inline)
        Text("@" + attendee.twitterHandle)
        Spacer()
    }
    
    func getImage(for person: Person) -> Image {
        if let imageData = person.getImage() {
            if let uiImage = UIImage(data: imageData) {
                return Image(uiImage: uiImage)
            }
        }

        return Image(systemName: "person.crop.square")
    }
}

struct PersonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailView(attendee: Person(name: "Boom", twitterHandle: "@Boom"))
    }
}
