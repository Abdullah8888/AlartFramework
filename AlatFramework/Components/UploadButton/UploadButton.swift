//
//  UploadButton.swift
//  AlatFramework
//
//  Created by Adjogbe  Tejiri on 22/03/2023.
//
import UIKit
import MobileCoreServices
import PDFKit

@IBDesignable public class UploadButton: BaseXib {
    
    @IBOutlet weak var contentStack: UIStackView!
    @IBOutlet weak var error: RegularLabel!
    @IBOutlet weak var errorStack: UIStackView!
    @IBOutlet weak var titleLabel: RegularLabel!
    @IBOutlet weak var infoLabel: ItalicLabel!
    @IBOutlet weak var uploadButton: PlainButton!
    @IBOutlet weak var uploadImage: UIImageView!
    
    @IBInspectable public var identifier: String = "" { didSet {
        self.accessibilityIdentifier = identifier
    } }
    
    @IBInspectable public var title: String = ""
    @IBInspectable public var info: String = ""
    @IBInspectable public var buttonText: String = "Upload"
    
    public var isOnlyPdf = false
    
    @IBInspectable public var errorText: String = "" {
        didSet { updateError() }
    }
    
    public var onSelected: (String, String) -> Void = { _, _ in }
    let Window = UIApplication.shared.windows.first
    var vc: UIViewController?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        vc = Window?.rootViewController
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        vc = Window?.rootViewController
    }
    
    @IBAction func uploadTapped(_ sender: Any) {
        selectFile()
    }
    
    public override func layoutSubviews() {
        setup()
    }
    
    func setup() {
        titleLabel.text = title
        infoLabel.text = info
        uploadButton.setTitle(buttonText, for: .normal)
        titleLabel.isHidden = title.isEmpty
        infoLabel.isHidden = info.isEmpty
        errorStack.isHidden = errorText.isEmpty
        updateHeight()
    }
    
    public override func prepareForInterfaceBuilder() {
        contentStack.widthAnchor.constraint(equalToConstant: superview?.bounds.width ?? 100).isActive = true
        setNeedsLayout()
    }
    
    public func reset() {
        uploadImage.image = AlatAssets.uploadIcon.image
        uploadImage.contentMode = .center
    }
    
    func updateError() {
        errorStack.isHidden = errorText.isEmpty
        error.text = errorText
    }
}


//MARK: Document Picker
extension UploadButton: UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentPickerDelegate {
    
    func selectFile() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let photoAction = UIAlertAction(title: "Select Image", style: .default) { [unowned self] _ in
            self.showImagePicker()
        }
        let pdfAction = UIAlertAction(title: "Select PDF", style: .default) { [unowned self] _ in
            self.showPDFPicker()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        if isOnlyPdf {
            actionSheet.addAction(pdfAction)
        } else {
            actionSheet.addAction(photoAction)
            actionSheet.addAction(pdfAction)
        }
        actionSheet.addAction(cancelAction)
        vc?.present(actionSheet, animated: true, completion: nil)
    }
    
    func showImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        vc?.present(imagePicker, animated: true, completion: nil)
    }
        
    // MARK: - Image Picker Delegate
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        let imageData = selectedImage?.jpegData(compressionQuality: 1.0)
        let base64String = imageData?.base64EncodedString()
        
        if let imageData = imageData, let selectedImage = selectedImage, let base64String = base64String {
            let fileSize = Double(imageData.count) / 1000000.0
            if fileSize <= 1.0 {
                uploadImage.image = selectedImage
                uploadImage.contentMode = .scaleToFill
                onSelected(base64String, ".jpg")
            } else {
                BottomModal.show(title: "Image should not be more than 1mb")
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func showPDFPicker() {
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypePDF as String], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        vc?.present(documentPicker, animated: true, completion: nil)
    }
    
    // MARK: - Document Picker Delegate
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        if let pdfURL = urls.first {
            if let pdfDocument = PDFDocument(url: pdfURL) {
                let pdfData = pdfDocument.dataRepresentation()
                let base64String = pdfData?.base64EncodedString()
                if let base64String = base64String, let pdfData = pdfData {
                    let fileSize = Double(pdfData.count) / 1000000.0
                    if fileSize <= 1.0 {
                        setPdfImage(pdfDocument: pdfDocument)
                        onSelected(base64String, ".pdf")
                    } else {
                        BottomModal.show(title: "Image should not be more than 1mb", type: .error)
                    }
                }
            }
        }
    }
    
    func setPdfImage(pdfDocument: PDFDocument) {
        let pdfPage = pdfDocument.page(at: 0)
        let pageSize = pdfPage?.bounds(for: .cropBox).size

        UIGraphicsBeginImageContextWithOptions(pageSize!, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.translateBy(x: 0.0, y: -pageSize!.height)
        
        pdfPage?.draw(with: .cropBox, to: context!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        uploadImage.contentMode = .scaleToFill
        uploadImage.image = image
    }
}
