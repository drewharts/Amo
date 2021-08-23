//
//  SenderView.swift
//  Amo
//
//  Created by Andrew Hartsfield II on 7/23/21.
//

import SwiftUI

struct SenderView: View {
    // I only need this moc here to send all the info to the main view
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State var image : Data = .init(count : 0)
    
    @State var show = false
    
    @State var name = ""
    
    @State var price = ""
    
    @State var link = ""
    
    @State var description = ""
    var body: some View {
        NavigationView {
        VStack {
            if self.image.count != 0 {
                Button(action: {
                    self.show.toggle()
                }) {
                    Image(uiImage: UIImage(data: self.image)!)
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .cornerRadius(6)
                }
            } else {
                Button(action: {
                    self.show.toggle()
                }) {
                Image(systemName: "photo.fill")
                    .font(.system(size: 55))
                    .foregroundColor(.gray)
                }
            }
            TextField("description", text: self.$name)
                .padding()
                .background(Color(red: 233/255, green: 234/255, blue: 243/255))
                .cornerRadius(20)
            
            TextField("price", text: self.$description)
                .padding()
                .background(Color(red: 233/255, green: 234/255, blue: 243/255))
                .cornerRadius(20)
            
            TextField("link", text: self.$link)
                .padding()
                .background(Color(red: 233/255, green: 234/255, blue: 243/255))
                .cornerRadius(20)
            
            Button(action: {
                let send = OverwearItem(context: self.moc)
                send.username = self.name
                send.price = self.description
                send.photo = self.image
                send.title = self.link
                
                try? self.moc.save()
                self.presentationMode.wrappedValue.dismiss()
                self.name = ""
                self.description = ""
                self.link = ""
            }) {
                Text("Send")
                    .fixedSize()
                    .frame(width: 250, height: 30)
                    .foregroundColor((self.name.count > 0 && self.description.count > 0 && self.image.count > 0) ? Color.white : Color.black)
                    .background((self.name.count > 0 && self.description.count > 0 && self.image.count > 0) ? Color.blue : Color.gray)
                    .cornerRadius(13)
            }
            
        }
            .navigationBarItems(trailing: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Text("Cancel")
        })
            
        }
        .sheet(isPresented: self.$show, content: {
            ImagePicker(show: self.$show, image: self.$image)
        })
        
    }
}
