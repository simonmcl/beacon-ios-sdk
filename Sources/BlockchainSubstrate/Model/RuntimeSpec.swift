//
//  RuntimeSpec.swift
//  
//
//  Created by Julia Samol on 10.01.22.
//

import Foundation

extension Substrate {
    
    public struct RuntimeSpec: Equatable, Codable {
        public let runtimeVersion: String
        public let transactionVersion: String
    }
}
