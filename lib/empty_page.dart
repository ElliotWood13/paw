import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

// TODO: Rename empty page
// TODO: Create header with logo that can be used everywhere

class EmptyPage extends StatelessWidget {
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
        Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
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
                      if (result.hasException) {
                        return Text(result.exception.toString());
                      }

                      if (result.isLoading) {
                        return CircularProgressIndicator();
                      }

                      final List posts = result.data?['posts'] ?? [];

                      if (posts.isEmpty) {
                        return Text('No posts found.');
                      }

                      return ListView.builder(
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          final post = posts[index];

                          return GestureDetector(
                            onTap: () {
                              // Handle tap to navigate to the full blog view
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                side: BorderSide(color: Colors.black, width: 4),
                              ),
                              clipBehavior: Clip.antiAlias,
                              elevation: 2.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (post['coverImage']?['url'] != null)
                                    Image.network(
                                      post['coverImage']['url'],
                                      width: double.infinity,
                                      height: 200.0,
                                      fit: BoxFit.cover,
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          post['title'] ?? 'No Title',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall,
                                        ),
                                        SizedBox(height: 8.0),
                                        Text(
                                          post['publishedAt'] ??
                                              'No Publication Date',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                        SizedBox(height: 8.0),
                                        Text(
                                          post['excerpt'] ?? 'No Excerpt',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
