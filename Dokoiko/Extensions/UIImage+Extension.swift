//
//  UIImage+Extension.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/05/12.
//

import Foundation
import UIKit

extension UIImage {
    /// 単色の色画像を生成する
    static func colorImage(withColor color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    /// Gifリソースに含まれる画像リストを返す
    /// 参考：https://stackoverflow.com/questions/27919620/how-to-load-gif-image-in-swift
    static func gifImages(resourceName: String) -> [UIImage] {
        guard let path = Bundle.main.path(forResource: resourceName, ofType: "gif") else {
            print("Gif does not exist at that path")
            return []
        }
        let url = URL(fileURLWithPath: path)

        guard let gifData = try? Data(contentsOf: url), let source = CGImageSourceCreateWithData(gifData as CFData, nil) else {
            print("GifData 生成失敗")
            return []
        }
        var images = [UIImage]()
        let imageCount = CGImageSourceGetCount(source)
        print("hoge", imageCount)
        for index in 0 ..< imageCount {
            if let image = CGImageSourceCreateImageAtIndex(source, index, nil) {
                images.append(UIImage(cgImage: image))
            }
        }
        return images
    }
}
