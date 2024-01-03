//
//  AddSheetView.swift
//  SparkFlow
//
//  Created by 贾建辉 on 2024/1/2.
//

import SwiftUI
import PhotosUI

struct AddSheetView: View {
    
    @State var titleValue = ""
    @State var contentValue = ""
    
    @StateObject var imageData = ImageData()
    
    @Environment(\.dismiss) var dismiss
    
    //CoreData
    @Environment(\.managedObjectContext) var viewContext
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("主题名称")
                            .modifier(SmallTitleStyle())
                        TextField("请输入主题", text: $titleValue)
                            .modifier(TextFieldStyle())
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("主题详情")
                            .modifier(SmallTitleStyle())
                        TextEditor(text: $contentValue)
                            .modifier(TextEditorStyle())
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("添加图片")
                            .modifier(SmallTitleStyle())
                        
                        HStack {
                            PhotosPicker(selection: $imageData.selectedImage, matching: .images) {
                                switch imageData.imageState {
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(16)
                                case .loading:
                                    ProgressView()
                                case .empty:
                                    Image(systemName: "plus")
                                        .modifier(AddImageStyle())
                                case .failure:
                                    Image(systemName: "")
                                    
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
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
        new.collected = false
        
        
        try? viewContext.save()
    }
}

struct AddSheetView_Previews: PreviewProvider {
    static var previews: some View {
        AddSheetView()
    }
}

//MARK: - 样式组件
//将样式组件化
struct SmallTitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 14))
            .foregroundColor(.gray)
            .padding(.horizontal, 8)
    }
}

struct AddImageStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 28, weight: .medium))
            .foregroundColor(Color(uiColor: .systemGray3))
            .frame(width: 100, height: 100)
            .background(Color.white.cornerRadius(16))
    }
}

struct TextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background {
                Color.white.cornerRadius(16)
            }
    }
}
struct TextEditorStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scrollContentBackground(.hidden)
            .frame(minHeight: 300)
            .padding()
            .background (
                Color.white.cornerRadius(16)
            )
    }
}
