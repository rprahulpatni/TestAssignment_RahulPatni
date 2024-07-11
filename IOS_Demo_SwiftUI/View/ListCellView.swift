//
//  ListCellView.swift
//  IOS_Demo_SwiftUI
//

import SwiftUI

struct ListCellView: View {
    var locationData: LocationData?
    
    var body: some View {
        HStack(alignment: .center){
            HStack(){
                let imgUrl = URL(string: locationData?.imageUrl ?? "")
                AsyncImage(url: imgUrl) { image in
                    image.resizable()
                            .frame(width: 80, height: 80)
                            .padding(5)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 80, height: 80)
                .cornerRadius(10)

                VStack(alignment: .leading, spacing: 10){
                    Text(locationData?.name ?? "")
                        .font(.headline)
                        .lineLimit(2)
                    Text(locationData?.description ?? "")
                        .font(.caption)
                        .lineLimit(2)
                }
            }.padding(.all, 10)
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        .background(.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.horizontal, 5)
        .listRowSeparator(.hidden)
    }
}

#Preview {
    ListCellView()
}
