import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:paw/components/elevated_button.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 16.0,
          left: 16.0,
          child: Image.asset(
            'assets/logo.png',
            width: 50.0,
            height: 50.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 60.0),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 0.0),
                    width: 375,
                    padding: const EdgeInsets.all(24.0),
                    decoration: BoxDecoration(
                      color: Color(0xFFD6DEFF),
                      borderRadius: BorderRadius.circular(48),
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Purr-fect Insurance for Your Best Friend!",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                textAlign: TextAlign.right,
                              ),
                              SizedBox(height: 16.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("• 24/7 vet support",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                  Text("• 99% claims fully covered",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                  Text("• free monthly treats",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                ],
                              ),
                              SizedBox(height: 24),
                              CustomElevatedButton(
                                text: "Pounce now!",
                                onPressed: () {
                                  // Handle button press
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: -50.0,
                    top: 70.0,
                    child: Image.asset(
                      'assets/cat_home_page.png',
                      width: 200.0,
                      height: 220.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              Text(
                'Latest Feline News',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                'Top tips, tricks and news for your cat',
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Query(
                    options: QueryOptions(
                      document: gql(
                        r'''
                        query GetPosts {
                          posts {
                            id
                            publishedAt
                            slug
                            title
                            excerpt
                            content {
                              text
                            }
                            coverImage {
                              url
                            }
                          }
                        }
                      ''',
                      ),
                    ),
                    builder: (QueryResult result,
                        {VoidCallback? refetch, FetchMore? fetchMore}) {
                      if (result.isLoading) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (result.hasException) {
                        print(result.exception.toString());
                        return Center(child: Text('Error fetching data'));
                      }

                      final List posts = result.data?['posts'] ?? [];

                      return ListView.builder(
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          final post = posts[index];
                          final String title =
                              post['title'] ?? 'No title available';

                          return GestureDetector(
                            onTap: () {
                              // Handle tap to navigate to the full blog view
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Center(
                                child: Container(
                                  width: 375.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(24),
                                    border: Border.all(
                                        color: Colors.black, width: 1),
                                  ),
                                  child: Row(
                                    children: [
                                      if (post['coverImage']?['url'] != null)
                                        ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(24),
                                            bottomLeft: Radius.circular(24),
                                          ),
                                          child: Image.network(
                                            post['coverImage']['url'],
                                            width: 100.0,
                                            height: 100.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      Flexible(
                                        child: Container(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            title,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
