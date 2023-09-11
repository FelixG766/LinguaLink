//
//  OCRManager.swift
//  LinguaLink
//
//  Created by Yangru Guo on 11/9/2023.
//

import Foundation
import CoreImage
import VisionKit
import Vision
import CoreML

struct OCRManager{
    
    func performOCRRequest(to sourceImage:UIImage) -> String {
        var recognisedText = ""
        let requestHandler = VNImageRequestHandler(ciImage: CIImage(image: sourceImage)!)
        let ocrRequest = VNRecognizeTextRequest{request, error in
            guard let textBlocks = request.results as? [VNRecognizedTextObservation] else {return}
            for textObservation in textBlocks{
                let topCandidate = textObservation.topCandidates(1)
                if let recognisedString = topCandidate.first {
                    recognisedText += recognisedString.string
                }
            }
        }
        ocrRequest.recognitionLevel = .accurate
        ocrRequest.automaticallyDetectsLanguage = true
        ocrRequest.usesLanguageCorrection = true
        try? requestHandler.perform([ocrRequest])
        return recognisedText
    }
}
