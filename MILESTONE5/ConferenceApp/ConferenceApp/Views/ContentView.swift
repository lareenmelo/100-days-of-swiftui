//
//  ContentView.swift
//  ConferenceApp
//
//  Created by Lareen Melo on 7/14/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAddNewProfile = false
    @ObservedObject var conferenceAttendees = Attendees()
    
    var sortedList: [Person] {
        return conferenceAttendees.attendeesList.sorted(by: >)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(sortedList) { attendee in
                    NavigationLink(destination: PersonDetailView(attendee: attendee)) {
                        HStack {
                            self.loadImage(for: attendee)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .foregroundColor(Color.gray)
                            
                            Text(attendee.name)
                            
                        }
                    }
                }
                .onDelete(perform: deleteAttendees)
            }
            .navigationBarTitle("ConferenceBook")
            .navigationBarItems(leading: EditButton(), trailing:
                                    Button(action: {
                                        showingAddNewProfile = true
                                        
                                    }, label: {
                                        Image(systemName: "plus")
                                    })
            )
            .sheet(isPresented: $showingAddNewProfile) {
                UploadImageView(attendees: conferenceAttendees)
            }
        }
    }
    
    func loadImage(for person: Person) -> Image {
        if let imageData = person.getImage() {
            if let uiImage = UIImage(data: imageData) {
                return Image(uiImage: uiImage)
            }
        }
        return Image(systemName: "person.crop.square")
        
    }
    
    func deleteAttendees(at offsets: IndexSet) {
        conferenceAttendees.attendeesList.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
