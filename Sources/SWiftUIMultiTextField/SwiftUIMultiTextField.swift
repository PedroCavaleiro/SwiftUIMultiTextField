import SwiftUI
import UIKit

public struct MultiTextField: UIViewRepresentable {
    
    @EnvironmentObject var obj: ObservedMultiTextField
    @Binding var text: String
    
    var placeholder: String = ""
    var maxSize: CGFloat = -1.0
    var textColor: UIColor = UIColor.black
    
    @State private var isPlaceholder: Bool = true
    
    public func makeUIView(context: UIViewRepresentableContext<MultiTextField>) -> UITextView {
        let view = UITextView()
        view.font = .systemFont(ofSize: 16)
        view.text = placeholder
        view.textColor = textColor.withAlphaComponent(0.35)
        view.backgroundColor = .clear
        view.delegate = context.coordinator
        obj.size = view.contentSize.height
        view.isEditable = true
        view.isUserInteractionEnabled = true
        view.isScrollEnabled = true
        return view
    }
    
    public func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<MultiTextField>) {
        
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    public class Coordinator: NSObject, UITextViewDelegate {
        
        var parent: MultiTextField
        
        init(parent: MultiTextField) {
            self.parent = parent
        }
        
        public func textViewDidBeginEditing(_ textView: UITextView) {
            if parent.isPlaceholder {
                textView.text = ""
                textView.textColor = parent.textColor
            }
        }
        
        public func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
            if textView.text.count > 0 {
                parent.isPlaceholder = false
            } else {
                parent.isPlaceholder = true
            }
            if parent.maxSize == -1 {
                parent.obj.size = textView.contentSize.height
            } else {
                parent.obj.size = textView.contentSize.height > parent.maxSize ? parent.maxSize : textView.contentSize.height
            }
        }
        
        public func textViewDidEndEditing(_ textView: UITextView) {
            if parent.isPlaceholder {
                textView.text = parent.placeholder
                textView.textColor = parent.textColor.withAlphaComponent(0.35)
            }
            
        }
        
    }
}

public class ObservedMultiTextField: ObservableObject {
    
    @Published var size: CGFloat = 0
    
}
