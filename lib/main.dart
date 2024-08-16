import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
import 'state/my_app_state.dart';

final HttpLink httpLink = HttpLink(
  'https://eu-west-2.cdn.hygraph.com/content/clzl2vxz601on07ut46mx17ev/master',
);

final AuthLink authLink = AuthLink(
  getToken: () async =>
      'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6ImdjbXMtbWFpbi1wcm9kdWN0aW9uIn0.eyJ2ZXJzaW9uIjozLCJpYXQiOjE3MjMxMDk1MzQsImF1ZCI6WyJodHRwczovL2FwaS1ldS13ZXN0LTIuaHlncmFwaC5jb20vdjIvY2x6bDJ2eHo2MDFvbjA3dXQ0Nm14MTdldi9tYXN0ZXIiLCJtYW5hZ2VtZW50LW5leHQuZ3JhcGhjbXMuY29tIl0sImlzcyI6Imh0dHBzOi8vbWFuYWdlbWVudC1ldS13ZXN0LTIuaHlncmFwaC5jb20vIiwic3ViIjoiZjIyZDRlMTYtMjk2Ny00YzQ4LWI1YTctYmM1ZGViZWM4NDliIiwianRpIjoiY2thNWoyZW9iMDN0YzAxd2gwZGZkNjdyeSJ9.SNWKtJ-P1p7VoVT-MmxnIWvEEEQ1E7mg2Z6OH_3kpbgkHOnosCdRQ3qpqfrZRakkkytClO8FH892L385n9xY6rveIOre4-zddBoxGJbRGykb_8VBVGLgRvVe_JZt-V44NS5ibbJEGCKjTMMXEO7jURNSx7ZGOj_bTW6PM_dmMDRdzg_ivQDT9ktPW4A2Wuy-jdWadNL-botOjBib6vI-RLSkmj-KdXTaT-GORSq3-9oPuJZK0UmMrrAiPKL4UdJimZcbLdTM4hbjdiwYKR1TtydFuslZ5dOP-l1fMhlq9B9FLud9Ins0Tr7xpVQUcIy8HcTYcfHI4o7_Xfn037R6z_dEE3vrUhD0MreYnx7v5ucvNMVTawg8fBKsZQbpCE897BfRv2vIyasHVkuEfeQ8zqaXcdZ7m28XPYWGs0Uoxsc5GryZPfFggkpUEUoGcaWpVCjIhSGGubMJU2CkKuP0zULEDVpS3KWBL8osG1o-ULilBRnMQngIMyQfpB0e0jGKV07pqj_MvOh6zVd5i1PW7je-xWYfRd3CX2cCLACFP1Cyll7PiC8Mndur9m42RaRgpSFenvb7PqhEffEX-EAjwlA25nwFt-8S_4jwsv2v7pMiMleBhZMtEm2EPLuc46i7MWmlrdos5e4sCAAFqZsePwTf4-jvMEkItMRNRT1wO3U',
);

final Link link = authLink.concat(httpLink);

final ValueNotifier<GraphQLClient> client = ValueNotifier(
  GraphQLClient(
    link: link,
    cache: GraphQLCache(store: InMemoryStore()),
  ),
);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        client: client,
        child: ChangeNotifierProvider(
          create: (context) => MyAppState(),
          child: MaterialApp(
            title: 'Paw',
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                  seedColor: Color.fromRGBO(254, 201, 255, 1)),
              textTheme: TextTheme(
                bodyMedium: TextStyle(fontSize: 16, color: Colors.black),
                labelLarge: TextStyle(fontSize: 16, color: Colors.black),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.disabled)) {
                      return Color.fromRGBO(228, 239, 224, 1);
                    }
                    return Color.fromRGBO(177, 255, 158, 1);
                  }),
                  foregroundColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.disabled)) {
                      return Colors.grey[700];
                    }
                    return Colors.black;
                  }),
                  padding: WidgetStateProperty.all(
                      EdgeInsets.symmetric(vertical: 16, horizontal: 32)),
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: Colors.black,
                      width: 3,
                    ),
                  )),
                  elevation: WidgetStateProperty.all(0),
                ),
              ),
            ),
            home: MyHomePage(),
          ),
        ));
  }
}
