import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var shareImage: UIImage?
    var selectedImage: String?
    var imagePosition: Int?
    var imageCount: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let imagePosition = self.imagePosition {
            if let imageCount = self.imageCount {
                title = "Picture \(imagePosition) of \(imageCount)"
            }
        }
        navigationItem.largeTitleDisplayMode = .never // affects the NavBar just for this screen(NavItem)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped() {
        if let imageWidth = imageView.image?.size.width {
            if let imageHeight = imageView.image?.size.height {
                let renderer = UIGraphicsImageRenderer(size: CGSize(width: imageWidth, height: imageHeight))
                let renderedImage = renderer.image { ctx in
                    imageView.image?.draw(at: CGPoint(x: 0, y: 0))
                    let shareString = "From Storm Viewer"
                    let attrs: [NSAttributedString.Key: Any] = [
                        .font: UIFont.systemFont(ofSize: 36)
                    ]
                    let attributedString = NSAttributedString(string: shareString, attributes: attrs)
                    attributedString.draw(at: CGPoint(x: 20, y: 20))
                }
                shareImage = renderedImage
            }
        }
        
        if let selectedImage = self.selectedImage {
            if let shareImage = self.shareImage {
                let vc = UIActivityViewController(activityItems: [shareImage, selectedImage], applicationActivities: [])
                vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
                present(vc, animated: true)
            }
        }
    }
}
