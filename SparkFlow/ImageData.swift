//
//  ImageData.swift
//  SparkFlow
//
//  Created by 贾建辉 on 2024/1/3.
//

import Foundation

import SwiftUI
import PhotosUI

class ImageData: ObservableObject {
    
    
    //对外发布数据
    @Published var selectedImage: UIImage? = nil
    
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            setImage(from: imageSelection)
        }
    }
    
    private func setImage(from selection: PhotosPickerItem?) {
        guard let selection else { return }
        
        Task {
            do {
                //1、将选择的图片转换为二进制数据
                let data = try await selection.loadTransferable(type: Data.self)
                
                //2、将二进制数据转为UIImage数据
                guard let data,
                      let uiImage = UIImage(data: data) else {
                    throw URLError(.badServerResponse)
                }
                
                DispatchQueue.main.async {
                    //3、将数据赋值
                    self.selectedImage = uiImage
                }
                
            } catch {
                print(error)
            }
        }
    }
    
    
}
