//
//  MainView.swift
//  Amo
//
//  Created by Andrew Hartsfield II on 8/16/21.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            Text("Outwear")
                .onTapGesture {
                }
                .tabItem {
                    Image(systemName: "star")
                    Text("One")
                }
        }
        }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
