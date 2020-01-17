//
//  EnterpriseCell.swift
//  ioasys
//
//  Created by Andre Costa Dantas on 17/01/20.
//  Copyright © 2020 Andre Costa Dantas. All rights reserved.
//

import Foundation
import Reusable

//MARK: Protocol
protocol NorrisFactCellDelegate: class {
    func share(image: UIImage?)
}

class NorrisFactCell: UITableViewCell, NibReusable {
    
    //MARK: Outlets
    @IBOutlet weak var factLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var categoriesCloudView: CategoriesTagView!
    
    //MARK: Variables
    weak var delegate: NorrisFactCellDelegate?
    var viewModel = FactItemViewModel()
    
    //MARK: Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupBindings()
        self.backgroundColor = .clear
        self.categoriesCloudView.configure(tagHeight: 32.0,
                                           tagBackgroundColor: UIColor.white.withAlphaComponent(0.2),
                                           textColor: UIColor.white)
    }
    
    func bind(_ fact: Fact) {
        self.viewModel.bind(fact)
    }
    
    func setupBindings() {
        self.viewModel.text
            .drive(factLabel.rx.text)
            .disposed(by: rx.disposeBag)
        
        self.viewModel.backgroundImage
            .drive(backgroundImage.rx.image)
            .disposed(by: rx.disposeBag)

        self.viewModel.fontSize
            .drive(factLabel.rx.fontSize)
            .disposed(by: rx.disposeBag)
        
        self.shareButton.rx.tap.bind { [weak self] in
            let image = self?.asImage()
            self?.delegate?.share(image: image)
        }.disposed(by: rx.disposeBag)
        
        self.viewModel.categories
            .drive(categoriesCloudView.rx.facts)
            .disposed(by: rx.disposeBag)
        
    }
}
extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
