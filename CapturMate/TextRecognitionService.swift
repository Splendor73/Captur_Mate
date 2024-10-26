import Vision
import AppKit

struct TextRecognitionService {
    static func recognizeText(from image: NSImage) -> String? {
        guard let tiffData = image.tiffRepresentation,
              let ciImage = CIImage(data: tiffData) else {
            return nil
        }

        let requestHandler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        let request = VNRecognizeTextRequest()

        do {
            try requestHandler.perform([request])
            guard let observations = request.results as? [VNRecognizedTextObservation] else {
                return nil
            }

            let recognizedText = observations.compactMap { observation in
                observation.topCandidates(1).first?.string
            }.joined(separator: "\n")

            print("Recognized Text: \(recognizedText)")
            return recognizedText
        } catch {
            print("Error recognizing text: \(error)")
            return nil
        }
    }
}
