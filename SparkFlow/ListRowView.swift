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
    
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.title)
                        .fontWeight(.bold)
                    Text(content)
                        .font(.system(size: 14))
                }
                
                HStack(spacing: 6) {
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
            .lineLimit(1)
            
            Spacer()
            RoundedRectangle(cornerRadius: 12)
                .frame(width: 70, height: 70)
        }
        .padding(4)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowView(title: "标题", content: "内容", timeStamp: "2024", collected: true)
    }
}
