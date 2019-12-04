//
//  CoreImageFilterNames.swift
//  Instafilter
//
//  Created by CypherPoet on 12/2/19.
// ✌️
//

import Foundation


enum CoreImageFilter {
    case bokehBlur
    case crystallize
    case edges
    case gaussianBlur
    case pixellate
    case sepiaTone
    case unsharpMask
    case vignette
}

extension CoreImageFilter: CaseIterable {}
extension CoreImageFilter: Identifiable { var id: String { ciFilterName }}




extension CoreImageFilter {
    
    var ciFilterName: String {
        switch self {
        case .bokehBlur:
            return "CIBokehBlur"
        case .crystallize:
            return "CICrystallize"
        case .edges:
            return "CIEdges"
        case .gaussianBlur:
            return "CIGaussianBlur"
        case .pixellate:
            return "CIPixellate"
        case .sepiaTone:
            return "CISepiaTone"
        case .unsharpMask:
            return "CIUnsharpMask"
        case .vignette:
            return "CIVignette"
        }
    }
    
    
    var displayName: String {
        switch self {
        case .bokehBlur:
            return "Bokeh Blur"
        case .crystallize:
            return "Crystallize"
        case .edges:
            return "Edges"
        case .gaussianBlur:
            return "Gaussian Blur"
        case .pixellate:
            return "Pixellate"
        case .sepiaTone:
            return "Sepia Tone"
        case .unsharpMask:
            return "Unsharp Mask"
        case .vignette:
            return "Vignette"
        }
    }
}

