import 'package:bookdone/article/page/article_main.dart';
import 'package:bookdone/bookinfo/page/bookinfo_detail.dart';
import 'package:bookdone/bookinfo/page/bookinfo_main.dart';
import 'package:bookdone/chat/page/chat_main.dart';
import 'package:bookdone/mypage/page/mypage_add_history.dart';
import 'package:bookdone/mypage/page/mypage_main.dart';
import 'package:bookdone/mypage/page/mypage_notifications.dart';
import 'package:bookdone/regist/page/regist_data.dart';
import 'package:bookdone/regist/page/regist_exist_list.dart';
import 'package:bookdone/regist/page/regist_new_check.dart';
import 'package:bookdone/search/page/search_main.dart';
import 'package:bookdone/search/service/search_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() {
  CustomNavigationHelper.instance;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SearchService()),
        ChangeNotifierProvider(create: (context) => SetNewRegion()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          primaryColor: Colors.white,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
          useMaterial3: true,
          fontFamily: "SCDream4",
          textTheme: TextTheme(
            bodyLarge: TextStyle(fontSize: 12),
            bodyMedium: TextStyle(fontSize: 15), // 기본 text fontsize
            bodySmall: TextStyle(fontSize: 12),
            labelLarge: TextStyle(fontSize: 15), // 기본 button fontsize
            displayMedium: TextStyle(fontSize: 12),
            titleMedium: TextStyle(fontSize: 13),
            titleLarge: TextStyle(fontSize: 15), // AppBar title
          ),
          bottomAppBarTheme: BottomAppBarTheme(color: Colors.white),
          bottomNavigationBarTheme:
              BottomNavigationBarThemeData(backgroundColor: Colors.white)),
      routerConfig: CustomNavigationHelper.router,
    );
  }
}

class CustomNavigationHelper {
  static final CustomNavigationHelper _instance =
      CustomNavigationHelper._internal();

  static CustomNavigationHelper get instance => _instance;

  static late final GoRouter router;

  static final GlobalKey<NavigatorState> parentNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> homeTabNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> searchTabNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> myPageTabNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> chatTabNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> registNavigatorKey =
      GlobalKey<NavigatorState>();

  BuildContext get context =>
      router.routerDelegate.navigatorKey.currentContext!;

  GoRouterDelegate get routerDelegate => router.routerDelegate;

  GoRouteInformationParser get routeInformationParser =>
      router.routeInformationParser;

  static const String homePath = '/home';
  static const String mypagePath = '/mypage';
  static const String searchPath = '/search';
  static const String addHistoryPath = '/addhistory';
  static const String chatPath = '/chat';
  static const String notificationPath = '/notification';
  static const String registPath = '/regist';
  static const String bookinfoDetailPath = '/bookinfodetail';

  factory CustomNavigationHelper() {
    return _instance;
  }

  CustomNavigationHelper._internal() {
    final routes = [
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: parentNavigatorKey,
        branches: [
          StatefulShellBranch(
            navigatorKey: homeTabNavigatorKey,
            routes: [
              GoRoute(
                name: 'home',
                path: '/home',
                pageBuilder: (context, GoRouterState state) {
                  return getPage(
                    child: const MyHomePage(),
                    state: state,
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: searchTabNavigatorKey,
            routes: [
              GoRoute(
                name: 'search',
                path: '/search',
                pageBuilder: (context, state) {
                  return getPage(
                    child: const SearchMain(),
                    state: state,
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: registNavigatorKey,
            routes: [
              GoRoute(
                name: 'registPath',
                path: '/regist',
                pageBuilder: (context, state) {
                  return getPage(
                    child: const RegistData(),
                    state: state,
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: chatTabNavigatorKey,
            routes: [
              GoRoute(
                name: 'chat',
                path: '/chat',
                pageBuilder: (context, state) {
                  return getPage(
                    child: const ChatMain(),
                    state: state,
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: myPageTabNavigatorKey,
            routes: [
              GoRoute(
                  name: 'mypage',
                  path: '/mypage',
                  pageBuilder: (context, state) {
                    return getPage(
                      child: const MyPageMain(),
                      state: state,
                    );
                  },
                  routes: [
                    GoRoute(
                      name: 'addhistory',
                      path: 'addhistory',
                      pageBuilder: (context, state) {
                        return getPage(
                          child: const MyPageAddHistory(),
                          state: state,
                        );
                      },
                    ),
                    GoRoute(
                      name: 'notification',
                      path: 'notification',
                      pageBuilder: (context, state) {
                        return getPage(
                          child: const MyPageNotifications(),
                          state: state,
                        );
                      },
                    )
                  ]),
            ],
          ),
        ],
        pageBuilder: (
          BuildContext context,
          GoRouterState state,
          StatefulNavigationShell navigationShell,
        ) {
          return getPage(
            child: BottomNavigationPage(
              child: navigationShell,
            ),
            state: state,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: parentNavigatorKey,
        name: 'bookinfoMain',
        path: '/bookinfomain',
        pageBuilder: (context, state) {
          return getPage(
            child: const BookinfoMain(),
            state: state,
          );
        },
        routes: [
          GoRoute(
            name: 'bookinfodetail',
            path: 'bookinfodetail',
            pageBuilder: (context, state) {
              return getPage(
                child: const BookinfoDetail(),
                state: state,
              );
            },
            routes: [
              GoRoute(
                parentNavigatorKey: parentNavigatorKey,
                name: 'articlemain',
                path: 'articlemain',
                pageBuilder: (context, state) {
                  return getPage(
                    child: const ArticleMain(),
                    state: state,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ];

    router = GoRouter(
      navigatorKey: parentNavigatorKey,
      initialLocation: homePath,
      routes: routes,
    );
  }

  static Page getPage({
    required Widget child,
    required GoRouterState state,
  }) {
    return MaterialPage(
      key: state.pageKey,
      child: child,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('책도네'),
      ),
      body: Center(),
    );
  }
}

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({
    super.key,
    required this.child,
  });

  final StatefulNavigationShell child;

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Bottom Navigator Shell'),
      // ),
      body: SafeArea(
        child: widget.child,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: widget.child.currentIndex,
        onTap: (index) {
          widget.child.goBranch(
            index,
            initialLocation: index == widget.child.currentIndex,
          );
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'regist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'settings',
          ),
        ],
      ),
    );
  }
}
