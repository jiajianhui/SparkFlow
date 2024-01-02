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
    
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                Text(content)
            }
            Spacer()
            Rectangle()
                .frame(width: 60, height: 60)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowView(title: "标题", content: "内容", timeStamp: "2024")
    }
}
