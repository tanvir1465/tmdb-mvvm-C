//
//  GradientView.swift
//  tmdb-rxswift-mvvm-c-maya
//
//  Created by Tanvir Hasan Piash on 14/1/21.
//

import UIKit

class GradientView: UIView {
    
    var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        return gradient
    }()
    
    var colors: [CGColor] = [UIColor.gray.cgColor, UIColor.white.cgColor] {
        
        didSet {
            
            gradient.colors = colors
            
        }
        
    }
    
    var startPoint: CGPoint = CGPoint.zero {
        
        didSet {
            
            gradient.startPoint = startPoint
            
        }
        
    }
    
    var endPoint: CGPoint = CGPoint(x: 1, y: 0) {
        
        didSet {
            
            gradient.endPoint = endPoint
            
        }
        
    }
    
    var locations: [NSNumber] = [0.0, 0.8] {
        
        didSet {
            
            gradient.locations = locations
            
        }
        
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupGradientLayer()
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        gradient.frame = self.bounds
        
    }
    
    private func setupGradientLayer() {
        
        gradient.colors = colors
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
