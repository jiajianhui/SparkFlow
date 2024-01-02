//
//  AddSheetView.swift
//  SparkFlow
//
//  Created by 贾建辉 on 2024/1/2.
//

import SwiftUI

struct AddSheetView: View {
    
    @State var titleValue = ""
    @State var contentValue = ""
    
    @Environment(\.dismiss) var dismiss
    
    //CoreData
    @Environment(\.managedObjectContext) var viewContext
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("主题名称")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                            .padding(.horizontal, 8)
                        TextField("请输入主题", text: $titleValue)
                            .padding()
                            .background {
                                Color.white.cornerRadius(16)
                            }
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("主题详情")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                            .padding(.horizontal, 8)
                        TextEditor(text: $contentValue)
                            .scrollContentBackground(.hidden)
                            .frame(minHeight: 600)
                            .padding()
                            .background (
                                Color.white.cornerRadius(16)
                            )
                    }
                }
                .padding(.horizontal)
            }
            .background {
                Color(uiColor: .systemGray6).ignoresSafeArea()
            }
            
            .navigationTitle("添加灵感")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("取消") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        AddEntity()
                        dismiss()
                    } label: {
                        Text("添加")
                            .fontWeight(.medium)
                    }

                }
            }
            
        }
    }
    
    func AddEntity() {
        let new = Entity(context: viewContext)
        
        new.title = titleValue
        new.content = contentValue
        new.timeStamp = Date()
        
        try? viewContext.save()
    }
    
    
    
    
}

struct AddSheetView_Previews: PreviewProvider {
    static var previews: some View {
        AddSheetView()
    }
}
