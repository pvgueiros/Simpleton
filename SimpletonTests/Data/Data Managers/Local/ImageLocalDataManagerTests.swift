//
//  ImageLocalDataManagerTests.swift
//  SimpletonTests
//
//  Created by Paula Vasconcelos Gueiros on 16/05/25.
//

import Testing
import Foundation
@testable import Simpleton

struct ImageLocalDataManagerTests {
    let imageLocalDataManager: ImageLocalDataManager
    
    init() {
        self.imageLocalDataManager = ImageLocalDataManager()
    }
    
    @Test func testSavesAndRetrievesImagesLocally() throws {
        let images = [
            SimpletonImageLocal(
                fromDomain: SimpletonImage(
                    id: "image1",
                    title: "Title 1",
                    urls: SimpletonImage.URLs(
                        small: "https://url.small1",
                        large: "https://url.large1"
                    ),
                    likes: 10,
                    username: "firstUser",
                    timestamp: Date()
                )
            ),
            SimpletonImageLocal(
                fromDomain: SimpletonImage(
                    id: "image2",
                    title: "Title 2",
                    urls: SimpletonImage.URLs(
                        small: "https://url.small2",
                        large: "https://url.large2"
                    ),
                    likes: 20,
                    username: "secondUser",
                    timestamp: Date()
                )
            )
        ]
        
        try imageLocalDataManager.saveImages(images)
        let retrievedImages = try imageLocalDataManager.getImages()
        
        #expect(retrievedImages != nil)
        #expect(retrievedImages == images)
    }
    
    @Test func testSavesAndRetrievesImageDataLocally() throws {
        let id = "imageData1"
        let data: Data = "Data content for testing".data(using: .utf8)!
        
        try imageLocalDataManager.saveImageData(data, forId: id)
        let retrievedData = try imageLocalDataManager.getImageData(forId: id)
        
        #expect(retrievedData != nil)
        #expect(retrievedData == data)
    }
    
    @Test func testDifferentiatesImageDataSizes() throws {
        let id2 = "imageData2"
        let data: Data = "Data content for testing".data(using: .utf8)!
        
        /// saving small
        try imageLocalDataManager.saveImageData(data, forId: id2, isLarge: false)
        /// retrieving large
        let retrievedData = try imageLocalDataManager.getImageData(forId: id2, isLarge: true)
        
        /// should not find image data in local storage
        #expect(retrievedData == nil)
    }
    
    @Test func testDifferentiatesImageIds() throws {
        let id3 = "imageData3"
        let id4 = "imageData4"
        let data: Data = "Data content for testing".data(using: .utf8)!
        
        /// saving id3
        try imageLocalDataManager.saveImageData(data, forId: id3)
        /// retrieving id4 for same data
        let retrievedData = try imageLocalDataManager.getImageData(forId: id4)
        
        /// should not find image data in local storage
        #expect(retrievedData == nil)
    }
}
