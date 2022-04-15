//
//  UIImageView + Download.swift
//  AppricotTsetProject
//
//  Created by Roman Efimov on 14.04.2022.
//
import UIKit

extension UIImageView {
    func download(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                print("error on download \(error ?? URLError(.badServerResponse))")
                return
            }
            guard 200 ..< 300 ~= response.statusCode else {
                print("statusCode != 2xx; \(response.statusCode)")
                return
            }
            guard let image = UIImage(data: data) else {
                print("not valid image")
                return
            }
            DispatchQueue.main.async {
                print("download completed \(url.lastPathComponent)")
                self.image = image
            }
        }.resume()
    }
}
