import 'dart:async';

import 'package:logging/logging.dart';
import 'package:flutterplate/core/data_sources/posts/posts_local_data_source.dart';
import 'package:flutterplate/core/data_sources/posts/posts_remote_data_source.dart';
import 'package:flutterplate/core/exceptions/cache_exception.dart';
import 'package:flutterplate/core/exceptions/network_exception.dart';
import 'package:flutterplate/core/exceptions/repository_exception.dart';
import 'package:flutterplate/core/models/post/post.dart';
import 'package:flutterplate/core/repositories/posts_repository/posts_repository.dart';
import 'package:flutterplate/core/services/connectivity/connectivity_service.dart';
import 'package:flutterplate/locator.dart';

class PostsRepositoryImpl implements PostsRepository {
  final remoteDataSource = locator<PostsRemoteDataSource>();
  final localDataSource = locator<PostsLocalDataSource>();
  final connectivityService = locator<ConnectivityService>();

  final _log = Logger('PostsRepositoryImpl');

  @override
  Future<List<Post>> fetchPosts() async {
    try {
      if (await connectivityService.isConnected) {
        final posts = await remoteDataSource.fetchPosts();
        await localDataSource.cachePosts(posts);
        return posts;
      } else {
        final posts = await localDataSource.fetchPosts();
        return posts;
      }
    } on NetworkException catch (e) {
      _log.severe('Failed to fetch posts remotely');
      throw RepositoryException(e.message);
    } on CacheException catch (e) {
      _log.severe('Failed to fetch posts locally');
      throw RepositoryException(e.message);
    }
  }
}
