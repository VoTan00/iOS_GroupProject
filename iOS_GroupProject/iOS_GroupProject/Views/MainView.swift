/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Group 27
  Created  date: 04/09/2023
  Last modified: 24/09/2023
  Acknowledgement: none
*/


import SwiftUI


struct MainView: View {
    @State var currentTab: Tab = .Home
    
    @StateObject var restaurantViewModel = RestaurantViewModel()
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var reviewViewModal: ReviewViewModel
    
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    @Namespace var animation
    var body: some View {
        
            TabView(selection: $currentTab) {
                // MARK: HOMEVIEW
                HomeView(restaurantViewModel : restaurantViewModel)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background()
                    .padding(.bottom, 40)
                    .tag(Tab.Home)
                
                // MARK: LISTVIEW
                ListView(restaurantViewModel : restaurantViewModel)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background()
                    .padding(.bottom, 40)
                    .tag(Tab.Favourite)
                
                // MARK: POSTVIEW
                PostsView(restaurantViewModel: restaurantViewModel)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background()
                    .padding(.bottom, 40)
                    .tag(Tab.Post)
                
                // MARK: PROFILEVIEW
                ProfileView(user: userViewModel.currentUser ?? User(id: "JkJacUS1vkV5sQbagw5jQhvfNhD3", email: "Thang2@gmail.com", profileImageUrl: "profile/0C0FE48D-51EE-43B5-8119-170F458CFCB1.jpg", username: "zet", bio: "Love Sleeping"))
                   .frame(maxWidth: .infinity, maxHeight: .infinity)
                   .background()
                   .tag(Tab.Account)
            }
            .overlay(
                // MARK: NAV BAR
                HStack (spacing: 0){
                    ForEach(Tab.allCases, id: \.rawValue) {tab in
                        TabButton(tab: tab)
                    }
                    .padding(.vertical)
                    .padding(.bottom, getSafeArea().bottom == 0 ? 5 : (getSafeArea().bottom - 15))
                    .background(Color("Color1"))
                }
                ,
                alignment: .bottom
            ).ignoresSafeArea(.all, edges: .bottom)
                .accentColor(Color("Color4"))
//        }
        
    }
        
    
    // MARK: TAB BUTTON
    func TabButton (tab: Tab) -> some View {
        GeometryReader{ proxy in
            Button(action: {
                withAnimation(.spring()) {
                    currentTab = tab
                }
            }, label: {
                VStack(spacing: 0){
                    Image(systemName: currentTab == tab ? tab.rawValue + ".fill": tab.rawValue)
                        .resizable()
                        .foregroundColor(Color("Color4"))
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .frame(maxWidth: .infinity)
                        .background(
                            ZStack{
                                if currentTab == tab {
                                    MaterialEffect(style: .light)
                                        .clipShape(Circle())
                                        .matchedGeometryEffect(id: "Tab", in: animation)
                                    
                                    Text(tab.TabName)
                                        .foregroundColor(Color("Color4"))
                                        .font(.footnote)
                                        .padding(.top, 50)
                                        .padding(.bottom, 10)
                                }
                            }
                        ).contentShape(Rectangle())
                        .offset(y: currentTab == tab ? -15 : 0)
                }
            })
        }
        .frame(height: 25)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(UserViewModel())
            .environmentObject(ReviewViewModel())
    }
}


enum Tab: String, CaseIterable {
    case Home = "house"
    case Favourite = "heart"
    case Post = "message"
    case Account = "person.crop.circle"
    
    var TabName: String {
        switch self {
        case .Home:
            return "Home"
        case .Favourite:
            return "Favourite"
        case .Post:
            return "Post"
        case .Account:
            return "Account"
        }
    }
}

extension View {
    func getSafeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        return safeArea
    }
}

struct MaterialEffect: UIViewRepresentable {
    var style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}
