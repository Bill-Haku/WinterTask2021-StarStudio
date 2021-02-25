//
//  FileManagementView.swift
//  WinterTask
//
//  Created by HakuBill on 2021/01/23.
//

import SwiftUI

class ModelObject: ObservableObject {
    @Published var isRefreshing: Bool = false {
        didSet {
            if isRefreshing {
                requestData()
            }
        }
    }
    
    func requestData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.isRefreshing = false
        }
    }
}

extension View {
    func addRefreshHeader(isRefreshing: Binding<Bool>, action: (() -> Void)? = nil) -> some View {
        self.background(PullRefresh(isRefreshing:isRefreshing,action: action))
      }
}

struct FileManagementView: View {
    @ObservedObject var modelObject = ModelObject()
    @State var showAlert = false
    @State var folderNameIn = ""
    var fileManager = FileManager.default
    
    var body: some View {
        func deleteRaw(at offsets: IndexSet) {
            if let first = offsets.first {
                try! fileManager.removeItem(at: fileListArray[first].url)
                fileListArray.remove(atOffsets: offsets)
                refreshFileList()
            }
        }
        
        return NavigationView {
            List {
                ForEach(fileListArray.indices, id: \.self) { index in
                    if fileListArray[index].fileType == 0 {
                        NavigationLink(destination: FileManagementView()) {
                            FileListView(file: fileListArray[index], id: index)
                                .frame(height: 80)
                        }
                    }
                    else if fileListArray[index].fileType == 1 {
                        NavigationLink(
                            destination: FileImageReader(file: fileListArray[index])) {
                            FileListView(file: fileListArray[index], id: index)
                                .frame(height: 80)
                        }
                    }
                    else if fileListArray[index].fileType == 3 {
                        NavigationLink(
                            destination: PDFReader(file: fileListArray [index])) {
                            FileListView(file: fileListArray[index], id: index)
                                .frame(height: 80)
                        }
                    }
                    else {
                        FileListView(file: fileListArray[index], id: index)
                            .frame(height: 80)
                    }
                }
                .onDelete(perform: deleteRaw)
            }
            .navigationBarTitle(Text("Files"), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.showAlert.toggle()
            }, label: {
                Image(systemName: "folder.badge.plus")
            }))
        }
        .edgesIgnoringSafeArea(.all)
        .addRefreshHeader(isRefreshing: $modelObject.isRefreshing)
        .alert(isPresented: $showAlert, TextAlert(title: "Add New Folder", placeholder: "New folder", action: {
            if let name = $0 {
                self.folderNameIn = name
                if createNewFolder(folderName: folderNameIn) {
                    print("create folder \(name) success")
                    refreshFileList()
                }
                else {
                    print("create folder \(name) fail")
                }
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
            guard let viewHost = uiView.superview?.superview else { return }
            guard let scrollView = self.scrollView(root: viewHost) else { return }
            if let refreshControl = scrollView.refreshControl {
                if self.isRefreshing {
                    refreshControl.beginRefreshing()
                    refreshFileList()
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
