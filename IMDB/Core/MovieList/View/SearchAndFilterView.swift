//
//  SearchAndFilterView.swift
//  IMDB
//
//  Created by Urvashi Gupta on 23/10/23.
//

import SwiftUI

struct SearchAndFilterView: View {
    @Binding var showSearchAndFilterView : Bool
    var body: some View {
        
        Button {
            withAnimation(.snappy) {
                showSearchAndFilterView.toggle()
            }
            
        } label: {
            Image(systemName: "xmark.circle")
                .imageScale(.large)
                .foregroundStyle(.red)
        }

        Text("Hello")
    }
}

#Preview {
    SearchAndFilterView(showSearchAndFilterView: .constant(false))
}
