//
//  ListRowView.swift
//  SparkFlow
//
//  Created by 贾建辉 on 2024/1/2.
//

import SwiftUI

struct ListRowView: View {
    
    var title: String
    var content: String
    var timeStamp: String
    var collected: Bool
    var uiImage: UIImage?
    
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.title2)
                        .fontWeight(.bold)
                    Text(content)
                        .font(.system(size: 14))
                }
                .lineLimit(1)
                
                Spacer()
                if let uiImage = uiImage {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: 60, height: 60)
                        .cornerRadius(10)
                }
            }
            
            //日期及收藏
            HStack(spacing: 4) {
                Image(systemName: "calendar")
                Text(timeStamp)
                
                Spacer()
                Image(systemName: "star.fill")
                    .foregroundColor(.orange)
                    .opacity(collected ? 1 : 0)
            }
            .font(.system(size: 12))
            .foregroundColor(.gray)
            
        }
        .padding(2)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowView(title: "标题", content: "内容", timeStamp: "2024", collected: true)
    }
}
