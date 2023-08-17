import UIKit

class ViewController: UIViewController {
    let emptyImageView = UIImageView()
    let filledImageView = UIImageView()
    let motionSlider = UISlider()
    var filledImageViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConfigures()
        setSubviews()
        setConstraints()
        motionSlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        
        setCompleted(percent: 0.5)
    }
    
    func setCompleted(percent: CGFloat) {
        filledImageViewHeightConstraint.isActive = false
        filledImageViewHeightConstraint = filledImageView.heightAnchor.constraint(equalToConstant: view.bounds.height * percent)
        filledImageViewHeightConstraint.isActive = true
        filledImageView.isHidden = (percent == 0)
        
        view.layoutIfNeeded()
    }
}

@objc
extension ViewController {
    func sliderValueChanged(_ sender: UISlider) {
        let percentage = CGFloat(sender.value)
        setCompleted(percent: percentage)
    }
}

extension ViewController {
    private func setConfigures() {
        view.backgroundColor = .white
        
        filledImageView.image = UIImage(named: "filled")
        filledImageView.contentMode = .bottom
        filledImageView.clipsToBounds = true
        
        emptyImageView.image = UIImage(named: "empty")
        emptyImageView.contentMode = .bottom
        emptyImageView.clipsToBounds = true
    }
    
    private func setSubviews() {
        view.addSubview(emptyImageView)
        emptyImageView.addSubview(filledImageView)
        view.addSubview(motionSlider)
    }
    
    private func setConstraints() {
        emptyImageView.translatesAutoresizingMaskIntoConstraints = false
        motionSlider.translatesAutoresizingMaskIntoConstraints = false
        filledImageView.translatesAutoresizingMaskIntoConstraints = false
        
        filledImageViewHeightConstraint = filledImageView.heightAnchor.constraint(equalToConstant: 0)
        
        NSLayoutConstraint.activate([
            emptyImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyImageView.topAnchor.constraint(equalTo: view.topAnchor),
            emptyImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            filledImageView.leadingAnchor.constraint(equalTo: emptyImageView.leadingAnchor),
            filledImageView.trailingAnchor.constraint(equalTo: emptyImageView.trailingAnchor),
            filledImageView.bottomAnchor.constraint(equalTo: emptyImageView.bottomAnchor),
            filledImageViewHeightConstraint,
            
            motionSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            motionSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            motionSlider.heightAnchor.constraint(equalToConstant: 40),
            motionSlider.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
}

