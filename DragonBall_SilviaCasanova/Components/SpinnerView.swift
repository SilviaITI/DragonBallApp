//
//  SpinnerView.swift
//  DragonBall_SilviaCasanova
//
//  Created by Silvia Casanova Martinez on 29/9/23.
//

import UIKit

class SpinnerView: UIView {

    private var shadowLayer: CAShapeLayer!
    private var cornerRadiusSpinner: CGFloat = 6
    private var fillColor: UIColor = .blue

    override func layoutSubviews() {
        super.layoutSubviews()
        // shadows configuration
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()

            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadiusSpinner).cgPath
            shadowLayer.fillColor = fillColor.cgColor

            shadowLayer.shadowColor = UIColor.black.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 1.0)
            shadowLayer.shadowOpacity = 0.2
            shadowLayer.shadowRadius = 4

            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
}
