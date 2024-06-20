//
//  DirectoryView.swift
//  Hackspaces
//
//  Created by Nithin Chelliya on 18.06.24.
//

import SwiftUI

struct DirectoryView: View {
    @State private var hackspaceArray: [Hackspace] = []
    @State private var selectedHackspace: Hackspace?
    @State private var isRefreshing = false

    var body: some View {
        NavigationView {
            VStack {
                HackspaceListView(hackspaces: hackspaceArray, onSelectHackspace: selectHackspace)
                    .refreshable {
                        directoryAPIWrapper()
                    }
                    .onAppear {
                        directoryAPIWrapper()
                    }
            }
            .navigationTitle("Hackspaces")
            .sheet(item: $selectedHackspace) { hackspace in
                HackspaceDetailView(hackspace: hackspace)
            }
        }
    }

    func directoryAPIWrapper() {
        APIService.makeDirectoryAPICall { [self] result in
            if let keys = result {
                self.hackspaceArray = keys.map { Hackspace(title: $0.name, apiUrl: $0.apiUrl) }
            }
        }
    }

    func selectHackspace(_ hackspace: Hackspace) {
        selectedHackspace = hackspace
    }
}

