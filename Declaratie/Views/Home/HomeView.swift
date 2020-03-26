//
//  HomeView.swift
//  Declaratie
//
//  Created by Danut Florian on 29/03/2020.
//  Copyright © 2020 Danut Florian. All rights reserved.
//

import SwiftUI
import FeedKit

struct NewsItem: Identifiable {
    var id = UUID()
    var title: String
    var url: String
}

struct HomeView: View {
    
    @EnvironmentObject var newsStore: NewsStore
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: Statement.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Statement.date, ascending: false)
    ]) var statements: FetchedResults<Statement>
    
    @State private var showCreate = false
    @State private var showOnboarding = false
    @State private var isNavigationBarHidden = true
    
    var hasOnboarded: Bool {
        UserDefaults.standard.bool(forKey: "isOnboarded")
    }
    
    var subtitle: String {
        if statements.count == 1 {
            return "Ai o declarație creată"
        }
        return "Ai \(statements.count) declarații create"
    }
    
    init(){
        UITableView.appearance().backgroundColor = UIColor.clear
        UITableViewCell.appearance().backgroundColor = UIColor.clear
        UITableView.appearance().tableFooterView = UIView()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("background").edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Știri")
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                            
                            Text("\(newsStore.news.count) articole")
                                .foregroundColor(.gray)
                        }
                        .padding(.leading, 30.0)
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(newsStore.news) { item in
                                Button(action: {
                                    if let url = URL(string: item.url) {
                                        UIApplication.shared.open(url)
                                    }
                                }) {
                                    GeometryReader { geometry in
                                        CardView(title: item.title)
                                            .rotation3DEffect(Angle(degrees:
                                                Double(geometry.frame(in: .global).minX - 30) / -40), axis: (x: 0, y: 10.0, z: 0))
                                    }
                                    .frame(width: 180, height: 180)
                                }
                            }
                        }
                        .padding(.leading, 30)
                        .padding(.top, 30)
                        .padding(.bottom, 60)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Declarații")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                        
                        Text(subtitle)
                            .foregroundColor(.gray)
                    }
                    .padding(.leading, 30.0)
                    
                    List {
                        ForEach(statements, id: \.date) { statement in
                            NavigationLink(destination: StatementView(statement: statement)
                                .navigationBarBackButtonHidden(true)
                                .navigationBarTitle(Text(""))
                                .navigationBarHidden(true)) {
                                VStack(alignment: .leading) {
                                    Text(statement.name)
                                        .font(.headline)
                                    Text(statement.destinationsString)
                                        .font(.callout)
                                }
                                .padding(.vertical)
                               
                            }
                        }
                        .onDelete(perform: deleteStatement)
                    }                
                    .cornerRadius(20)
                    Spacer()
                }
                VStack {
                    HStack {
                        Spacer()
                        VStack {
                            Button(action: {
                                self.showOnboarding = true
                            }) {
                                CircleButton()
                            }
                            .sheet(isPresented: $showOnboarding) {
                                OnboardingView()
                            }
                        }
                    }
                    Spacer()
                    Button(action: {
                        self.showCreate = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(Color("background3"))
//                            .shadow(color: .gray, radius: 0.2, x: 1, y: 1)
                    }
                    .sheet(isPresented: $showCreate) {
                        CreateView()
                    }
                }
                .padding(.top, 5)
                .padding(.horizontal, 30)
                .padding(.bottom, 30)
            }
            .navigationBarTitle("Declaratii")
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea([.bottom])
            .onAppear {
                self.fetch()
                self.showOnboarding = !self.hasOnboarded
            }
        }
    }
    
    func fetch() {
        newsStore.fetch(url: "https://cdn.stirioficiale.ro/feeds/informatii.xml")
    }
    
    func deleteStatement(at offsets: IndexSet) {
        for offset in offsets {
            let statement = statements[offset]
            PDFManager.delete(name: statement.pdfName)
            moc.delete(statement)
        }
        try? moc.save()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        return HomeView()
            .environment(\.managedObjectContext, context)
            .environmentObject(NewsStore())
    }
}
