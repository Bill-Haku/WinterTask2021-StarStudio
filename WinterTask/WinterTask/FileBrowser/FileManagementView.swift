//
//  FileManagementView.swift
//  WinterTask
//
//  Created by HakuBill on 2021/01/23.
//

import SwiftUI

struct FileManagementView: View {
    @State var isRefreshing: Bool = false
    //var fileListArray = getAllFileName(folderPath: documentPath)
    var body: some View {
        NavigationView {
            List(fileListArray) { file in
                FileListView(file: file)
            }
            .navigationBarTitle(Text("Files"), displayMode: .inline)
        }
        .background(PullRefresh(isRefreshing: $isRefreshing, action: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        self.isRefreshing = false
                    }
                }))
    }
}

struct PullRefresh: UIViewRepresentable {
    @Binding var isRefreshing: Bool
    let action: (() -> Void)?
    
    init(isRefreshing: Binding<Bool>,action: (() -> Void)? = nil) {
        _isRefreshing = isRefreshing
        self.action = action
    }
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            guard let viewHost = uiView.superview?.superview else {
                return
            }
            guard let scrollView = self.scrollView(root: viewHost) else {
                return
            }
            if let refreshControl = scrollView.refreshControl {
                if self.isRefreshing {
                    refreshControl.beginRefreshing()
                } else {
                    refreshControl.endRefreshing()
                }
                
            }else {
                let refreshControl = UIRefreshControl()
                scrollView.refreshControl = refreshControl
                context.coordinator.setupObserver(scrollView)
            }
            
        }
    }
    
    static func dismantleUIView(_ uiView: UIView, coordinator: Coordinator) {
        coordinator.clearObserver()
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator($isRefreshing, action: action)
    }
    
    class Coordinator {
        let isRefreshing: Binding<Bool>
        let action: (() -> Void)?
        private var stateToken: NSKeyValueObservation?
        private var initOffset:CGFloat = 0
        
        init(_ isRefreshing: Binding<Bool>,action: (() -> Void)?) {
            self.isRefreshing = isRefreshing
            self.action = action
        }

        func setupObserver(_ scrollView: UIScrollView) {
            initOffset = scrollView.contentOffset.y
            stateToken = scrollView.observe(\.panGestureRecognizer.state) {
                [weak self] scrollView,_  in
                print(scrollView.contentOffset.y)
                guard scrollView.panGestureRecognizer.state == .ended else { return }
                
                self?.scrollViewDidEndDragging(scrollView)
            }
        }
        func clearObserver() {
            stateToken?.invalidate()
        }
        
        func scrollViewDidEndDragging(_ scrollView: UIScrollView) {
            if isRefreshing.wrappedValue {
                return
            }
            if initOffset - scrollView.contentOffset.y < 40 {
                return
            }
            isRefreshing.wrappedValue = true
            if let actionMethod = action {
                actionMethod()
            }
        }
        
    }
    
    private func scrollView(root: UIView) -> UIScrollView? {
        for subview in root.subviews {
            if subview.isKind(of: UIScrollView.self) {
                return subview as? UIScrollView
            } else if let scrollView = scrollView(root: subview) {
                return scrollView
            }
        }
        return nil
    }
    
}

struct FileManagementView_Previews: PreviewProvider {
    static var previews: some View {
        FileManagementView()
    }
}
