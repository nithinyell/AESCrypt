//
//  AESCrypt.swift
//  AESCryptDemo
//
//  Created by Nithin on 8/25/18.
//  Copyright © 2018 Apple INC. All rights reserved.
//

import UIKit

let PASSWORD = "Swift$"

class AESCrypt {
    
    class func AESStringEncryption(message: String?) -> String? {
        
        guard let messageData = message?.data(using: .utf8),
            let keyData = PASSWORD.data(using: .utf8),
            let cryptData = NSMutableData(length: messageData.count + kCCBlockSizeAES128)
            else {
                print("Trying to Encrypt either nil message or password")
                return nil
        }
        
        let keyLength = size_t(kCCKeySizeAES128)
        let operation = UInt32(kCCEncrypt)
        let algoritm = UInt32(kCCAlgorithmAES128)
        let options = UInt32(kCCOptionPKCS7Padding)
        var numBytesEncrypted :size_t = 0
        
        let cryptStatus = CCCrypt(operation,
                                  algoritm,
                                  options,
                                  (keyData as NSData).bytes, keyLength,
                                  nil,
                                  (messageData as NSData).bytes, messageData.count,
                                  cryptData.mutableBytes, cryptData.length,
                                  &numBytesEncrypted)
        
        if cryptStatus == kCCSuccess {
            
            cryptData.length = Int(numBytesEncrypted)
            let base64cryptString = cryptData.base64EncodedString(options: .lineLength64Characters)
            
            return base64cryptString
            
        }
        
        print("Failed to Encrypt message and password")
        return nil
    }
    
    class func AESStringDecryption(message: String?) -> String? {
        
        guard let message = message,
            let messageData = NSData(base64Encoded: message, options: .ignoreUnknownCharacters),
            let keyData = PASSWORD.data(using: .utf8),
            let cryptData = NSMutableData(length: messageData.length + kCCBlockSizeAES128)
            else {
                print("Trying to Decrypt either nil message or password")
                return nil
        }
        
        let keyLength = size_t(kCCKeySizeAES128)
        let operation = UInt32(kCCDecrypt)
        let algoritm = UInt32(kCCAlgorithmAES128)
        let options = UInt32(kCCOptionPKCS7Padding)
        var numBytesEncrypted :size_t = 0
        
        let cryptStatus = CCCrypt(operation,
                                  algoritm,
                                  options,
                                  (keyData as NSData).bytes, keyLength,
                                  nil,
                                  messageData.bytes, messageData.length,
                                  cryptData.mutableBytes, cryptData.length,
                                  &numBytesEncrypted)
        
        if cryptStatus == kCCSuccess {
            
            cryptData.length = Int(numBytesEncrypted)
            
            if let unencryptedMessage = String(data: cryptData as Data, encoding:.utf8) {
                
                return unencryptedMessage
            }
        }
        
        print("Failed to Decrypt message and password")
        return nil
    }
    
    class func AESImageEncryption(image: UIImage?) -> NSData? {
        
        guard let image = image, let imageData = image.pngData(),
            let keyData = PASSWORD.data(using: .utf8),
            let cryptData = NSMutableData(length: imageData.count + kCCBlockSizeAES128)
            else {
                print("Trying to Encrypt either nil image or password")
                return nil
        }
        
        let keyLength = size_t(kCCKeySizeAES128)
        let operation = UInt32(kCCEncrypt)
        let algoritm = UInt32(kCCAlgorithmAES128)
        let options = UInt32(kCCOptionPKCS7Padding)
        var numBytesEncrypted :size_t = 0
        
        let cryptStatus = CCCrypt(operation,
                                  algoritm,
                                  options,
                                  (keyData as NSData).bytes, keyLength,
                                  nil,
                                  (imageData as NSData).bytes, (imageData as NSData).length,
                                  cryptData.mutableBytes, cryptData.length,
                                  &numBytesEncrypted)
        
        if cryptStatus == kCCSuccess {
            
            cryptData.length = Int(numBytesEncrypted)
            let image = cryptData.base64EncodedData(options: .lineLength64Characters)
            
            return image as NSData
        }
        
        print("Failed to Encrypt image and password")
        return nil
    }
    
    class func AESImageDecryption(data: NSData?) -> UIImage? {
        
        guard let data = data,
            let encodedData = NSData(base64Encoded: data as Data, options: .ignoreUnknownCharacters),
            let keyData = PASSWORD.data(using: .utf8),
            let cryptData = NSMutableData(length: encodedData.length + kCCBlockSizeAES128)
            else {
                print("Trying to Decrypt either nil image or password")
                return nil
        }
        
        let keyLength = size_t(kCCKeySizeAES128)
        let operation = UInt32(kCCDecrypt)
        let algoritm = UInt32(kCCAlgorithmAES128)
        let options = UInt32(kCCOptionPKCS7Padding)
        var numBytesEncrypted :size_t = 0
        
        let cryptStatus = CCCrypt(operation,
                                  algoritm,
                                  options,
                                  (keyData as NSData).bytes, keyLength,
                                  nil, encodedData.bytes, encodedData.length,
                                  cryptData.mutableBytes, cryptData.length,
                                  &numBytesEncrypted)
        
        if cryptStatus == kCCSuccess {
            
            cryptData.length = numBytesEncrypted
            
            if let image = UIImage(data: cryptData as Data) {
                
                return image
            }
        }
        
        print("Failed to Decrypt image and password")
        return nil
    }
}

