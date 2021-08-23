//
//  ContentView.swift
//  Amo
//
//  Created by Andrew Hartsfield on 6/18/21.
//

import SwiftUI
import FirebaseAuth

let myCustomColor = UIColor(red: 38/255.0, green: 49/255.0, blue: 197/255.0, alpha: 1.0) // sRGB

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: OverwearItem.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \OverwearItem.title, ascending: true),
        NSSortDescriptor(keyPath: \OverwearItem.price, ascending: true),
        NSSortDescriptor(keyPath: \OverwearItem.photo?, ascending: true),
        NSSortDescriptor(keyPath: \OverwearItem.username, ascending: true),
        NSSortDescriptor(keyPath: \OverwearItem.favo, ascending: true)
        ]
    ) var savings : FetchedResults<OverwearItem>
    
    @State var image: Data = .init(count: 0)
    
    @State var title: String = "www.apple.com"
    
    @State private var show = false
    
    @State private var someState = false
    
    @State private var selectedTab = 0
    
    //Shoe item housekeeping
    @Environment(\.managedObjectContext) var moc1
    @FetchRequest(entity: ShoeItem.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \ShoeItem.title, ascending: true),
        NSSortDescriptor(keyPath: \ShoeItem.price, ascending: true),
        NSSortDescriptor(keyPath: \ShoeItem.photo?, ascending: true),
        NSSortDescriptor(keyPath: \ShoeItem.username, ascending: true),
        NSSortDescriptor(keyPath: \ShoeItem.favo, ascending: true)
        ]
    ) var savings1 : FetchedResults<ShoeItem>
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        LoginScreen()
        TabView {
            NavigationView {
                List {
                    ForEach(savings, id: \.self) { save in
                        VStack(alignment: .leading) {
                            if save.photo?.count != nil {
                                Image(uiImage: UIImage(data: save.photo ?? self.image)!)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 300, height: 300)
                                    .cornerRadius(15)
                            }
                            else {
                                Image("LoadingImage")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 600, height: 200)
                                    .cornerRadius(15)
                            }
                            
                            
                            HStack {
                            Text("\(save.username ?? "")")
                                Spacer()
                                
    //                            Button(action: {
    ////                                save.favo.toggle()
    ////                                try? self.moc.save()
    //                                Link(destination: URL(string:\(save.title)))
    //                            }){
    //                               " Image(systemName: save.favo ? "bookmark.fill": "bookmark")
    //                            }
    //                            let url = "\(save.title)"
    //                Link("View Our Terms of Service",
    //                     destination: URL(string: url)!)
                                
                    }
                        Text("\(save.price ?? "")$")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("\(save.title ?? "")")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        }
                        
                    }.onDelete(perform: deleteOverwear)
                     .padding()
                    }.navigationBarTitle("Overwear", displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                        self.show.toggle()
                    }) {
                        Image(systemName: "camera.fill")
                    })
                .sheet(isPresented: $show) {
                    SenderView().environment(\.managedObjectContext, self.moc)
                }
                
                }
                .onTapGesture {
                    self.selectedTab = 1
                }
                .tabItem {
                    Image(systemName: "cloud.snow")
                    Text("Outerwear")
                }
            Text("Pants")
            NavigationView {
                List {
                    ForEach(savings1, id: \.self) { save in
                        VStack(alignment: .leading) {
                            if save.photo?.count != nil {
                                Image(uiImage: UIImage(data: save.photo ?? self.image)!)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 300, height: 300)
                                    .cornerRadius(15)
                            }
                            else {
                                Image("LoadingImage")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 600, height: 200)
                                    .cornerRadius(15)
                            }
                            
                            
                            HStack {
                            Text("\(save.username ?? "")")
                                Spacer()
                                
    //                            Button(action: {
    ////                                save.favo.toggle()
    ////                                try? self.moc.save()
    //                                Link(destination: URL(string:\(save.title)))
    //                            }){
    //                               " Image(systemName: save.favo ? "bookmark.fill": "bookmark")
    //                            }
    //                            let url = "\(save.title)"
    //                Link("View Our Terms of Service",
    //                     destination: URL(string: url)!)
                                
                    }
                        Text("\(save.price ?? "")$")
                            .font(.caption)
                            .foregroundColor(.secondary)
    //                    Text("\(save.title ?? "")")
    //                        .font(.caption2)
    //                        .foregroundColor(.secondary)
                        }
                        
                    }.onDelete(perform: deleteShoes)
                     .padding()
                    }.navigationBarTitle("Pants", displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                        self.show.toggle()
                    }) {
                        Image(systemName: "camera.fill")
                    })
                
                }
            .sheet(isPresented: $show) {
                SenderViewShoes().environment(\.managedObjectContext, self.moc1)
            }
                .onTapGesture {
                    self.selectedTab = 2
                }
                .tabItem {
                    Image(systemName: "pause")
                    Text("Pants")
                }
            Text("Shoes")
                .onTapGesture {
                    self.selectedTab = 2
                }
                .tabItem {
                    Image(systemName: "pause")
                    Text("Shoes")
                }
    }
    }
    func deleteOverwear(at offsets: IndexSet) {
        for offset in offsets {
            let clothe = savings[offset]
            moc.delete(clothe)
        }
        try? moc.save()
    }
    func deleteShoes(at offsets: IndexSet) {
        for offset in offsets {
            let shoe = savings1[offset]
            moc1.delete(shoe)
        }
        try? moc1.save()
    }
}

