//
//  PosterImageHolder.swift
//  IMDB
//
//  Created by Urvashi Gupta on 24/08/23.
//

import SwiftUI

struct PosterImageHolder: Shape {
   
        func path(in rect : CGRect) -> Path{
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight,.bottomLeft], cornerRadii: CGSize(width: 16, height: 16))
            return Path(path.cgPath)
        }
    
}

struct PosterImageHolder_Previews: PreviewProvider {
    static var previews: some View {
        PosterImageHolder()
    }
}
