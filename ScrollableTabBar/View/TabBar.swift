//
//  TabBar.swift
//  ScrollableTabBar
//
//  Created by RJ Hrabowskie on 2/8/21.
//

import SwiftUI

struct TabBar: View {
    @Binding var offset: CGFloat
    @Binding var showCapsule: Bool
    @State var width: CGFloat = 0
    
    var body: some View {
        GeometryReader {proxy -> AnyView in
            let equalWidth = proxy.frame(in: .global).width / CGFloat(tabs.count)
            
            DispatchQueue.main.async {
                self.width = equalWidth
            }
            
            return AnyView (
                ZStack(alignment: .bottomLeading, content: {
                    
                    Capsule()
                        .fill(Color("lightblue"))
                        .frame(width: equalWidth - 15, height: showCapsule ? 40 : 4)
                        .offset(x: getOffset() + 7)
                    
                    HStack(spacing: 0) {
                        ForEach(tabs.indices, id: \.self) {index in
                            Text(tabs[index])
                                .fontWeight(.bold)
                                .foregroundColor(showCapsule ? (getIndexFromOffset() == CGFloat(index) ? .black : .white) : .white)
                                .frame(width: equalWidth, height: 40)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    withAnimation {
                                        offset = UIScreen.main.bounds.width * CGFloat(index)
                                    }
                                }
                        }
                    }
                })
                .frame(maxWidth: .infinity, maxHeight: 40, alignment: .center)
                .clipShape(Capsule())
            )
        }
        .padding()
        .frame(height: 40)
    }
    
    // Calculating Offset
    func getOffset() -> CGFloat {
        let progress = offset / UIScreen.main.bounds.width
        
        return progress * width
    }
    
    func getIndexFromOffset() -> CGFloat {
        let indexFloat = offset / UIScreen.main.bounds.width
        
        return indexFloat.rounded(.toNearestOrAwayFromZero)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
