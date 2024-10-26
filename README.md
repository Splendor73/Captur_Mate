---

# CapturMate

CapturMate is a macOS application developed by **Yashu Patel**, designed to help users effortlessly capture screenshots and extract text from images. The app allows users to upload images or capture screen areas, recognize text using Optical Character Recognition (OCR) with Apple's Vision framework, and copy the extracted text to the clipboard for further use. It is ideal for students, professionals, and anyone who needs to digitize printed or displayed text.

## Features

- **Capture and Upload Images**: Easily upload images from the file system or capture screenshots for text extraction.
- **OCR Text Extraction with Vision API**: Extract text from images using macOS's built-in Vision framework for OCR.
- **Copy Text to Clipboard**: Quickly copy the recognized text to the clipboard for easy pasting into other applications.
- **User-Friendly Interface**: Simple and intuitive interface designed for macOS, with a consistent macOS-style appearance.
- **Support for Multiple Image Formats**: Works with popular image formats like PNG and JPEG.

## Technologies Used

- **Language**: Swift
- **Framework**: Apple's Vision framework
- **macOS Compatibility**: macOS 11.0 or later
- **Development Environment**: Xcode 12 or later

## Screenshots

> <img width="1012" alt="image" src="https://github.com/user-attachments/assets/9a4921de-6ca6-4fb7-9a99-e56a0ca2da4f">

> <img width="1012" alt="image" src="https://github.com/user-attachments/assets/87161a2d-f930-4a13-aac6-d811a742f03b">



## Getting Started

### Prerequisites

- macOS 11.0 or later.
- Xcode 12 or later.
- Swift 5.3 or later.

### Installation

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/your-username/CapturMate.git
   cd CapturMate
   ```
2. **Open the Project in Xcode:**
   - Open `CapturMate.xcodeproj` or `CapturMate.xcworkspace` in Xcode.

3. **Build and Run the Project:**
   - Select your target device (e.g., "My Mac") and hit `Cmd + R` to build and run the app.

## Usage

1. **Upload or Capture an Image:**
   - Click the "Select Window" button to upload an image or capture a screen area.

2. **Text Extraction:**
   - The app will automatically extract text from the selected image using the Vision framework and display it in the text area.

3. **Copy to Clipboard:**
   - Click the "Copy to Clipboard" button to copy the extracted text for use in other applications.

## How It Works

CapturMate uses the Vision framework's OCR capabilities to recognize text from images. Here’s a brief overview of how the app is structured:

1. **TextRecognitionViewModel**: Manages the state of the application and handles text extraction.
2. **Vision API Integration**: Uses `VNRecognizeTextRequest` to detect and recognize text from the uploaded image.
3. **Clipboard Integration**: Provides functionality to copy the extracted text to the macOS clipboard.

### Code Snippets

#### Using Vision Framework for Text Recognition

```swift
import Vision

func recognizeText(from image: NSImage) -> String? {
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

        return recognizedText
    } catch {
        print("Error recognizing text: \(error)")
        return nil
    }
}
```

## Contributing

Contributions are welcome! If you want to contribute to the project, please follow these steps:

1. **Fork the Repository**
2. **Create a Feature Branch** (`git checkout -b feature-branch`)
3. **Commit Your Changes** (`git commit -m 'Add some feature'`)
4. **Push to the Branch** (`git push origin feature-branch`)
5. **Open a Pull Request**

## License

This project is licensed under the MIT License. See the `LICENSE` file for more details.

## Author

**Yashu Patel**

- GitHub: [@Splendor73](https://github.com/Splendor73)
- LinkedIn: [Yashu Patel](https://www.linkedin.com/in/yashu-patel)

## Keywords / Technology

- Swift OCR
- macOS Vision framework
- Apple Vision API
- Text recognition Swift
- Screenshot text extraction
- CapturMate
- Swift macOS app


## Acknowledgements

- **Apple's Vision Framework** for providing powerful OCR capabilities.
- **Swift Community** for helpful resources and guidance.

---
