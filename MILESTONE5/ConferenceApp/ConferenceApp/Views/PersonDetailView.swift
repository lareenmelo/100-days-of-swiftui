//
//  PersonDetailView.swift
//  ConferenceApp
//
//  Created by Lareen Melo on 7/14/21.
//

import SwiftUI
import MapKit

struct PersonDetailView: View {
    var attendee: Person
    
    var body: some View {
        getImage(for: attendee)
            .resizable()
            .scaledToFit()
            .foregroundColor(Color.gray)
            .navigationBarTitle(Text(attendee.name), displayMode: .inline)
        // Day 78
        Form {
            Section(header: Text("Location Met")) {
                if attendee.locationRecorded {
                    NavigationLink(destination: MapView(annotation: getAnnotation()).ignoresSafeArea(.all)) {
                        MapView(annotation: getAnnotation())
                            .frame(minHeight: 150)
                    }
                    
                } else {
                    Text("Location was not recorded for this contact")
                        .padding()
                }
            }
            
            Section(header: Text("Twitter Handle")) {
                HStack {
                    Image("twitter")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32, alignment: .center)
                        .clipShape(Circle())

                    Text("@" + attendee.twitterHandle)
                }
            }
        }
    }
    
    func getImage(for person: Person) -> Image {
        if let imageData = person.getImage() {
            if let uiImage = UIImage(data: imageData) {
                return Image(uiImage: uiImage)
            }
        }

        return Image(systemName: "person.crop.square")
    }
    
    // Day 78
    func getAnnotation() -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: attendee.latitude, longitude: attendee.longitude)
        return annotation
    }
}

struct PersonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailView(attendee: Person(name: "Boom", twitterHandle: "@Boom"))
    }
}
