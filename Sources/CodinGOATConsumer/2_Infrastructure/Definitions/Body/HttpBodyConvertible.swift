//
//  HttpBodyConvertible.swift
//
//  Created by Jewel CHERIAA on 06/06/2023.
//

import Foundation

public protocol HttpBodyConvertible {
    func toHttpMultipartData(boundary: String) -> Data
}

extension FileModel: HttpBodyConvertible {
    public func toHttpMultipartData(boundary: String) -> Data {
        let httpBody = NSMutableData()
        httpBody.appendDataFrom("--\(boundary)\r\n")
        httpBody.appendDataFrom("Content-Disposition: form-data; name=\"\(attributeKey)\"; filename=\"\(fileName)\"\r\n")
        httpBody.appendDataFrom("Content-Type: \(mimeType)\r\n\r\n")
        httpBody.append(fileData)
        httpBody.appendDataFrom("\r\n")
        return httpBody as Data
    }
}

extension Params: HttpBodyConvertible {
    public func toHttpMultipartData(boundary: String) -> Data {
        let httpBody = NSMutableData()
        forEach { key, value in
            httpBody.appendDataFrom("--\(boundary)\r\n")
            httpBody.appendDataFrom("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            httpBody.appendDataFrom(value.description)
            httpBody.appendDataFrom("\r\n")
        }
        return httpBody as Data
    }
}
