import 'package:creative_run/model/category.dart';
import 'package:creative_run/model/project.dart';
import 'package:creative_run/model/project_details.dart';
import 'package:creative_run/repo/database/database_client.dart';
import 'package:creative_run/repo/network/category_data_provider.dart'
    as categoryDataProvider;
import 'package:creative_run/repo/network/project_data_provider.dart'
    as projectDataProvider;
import 'package:http/http.dart';

class Repository {
  final Client _httpClient;

  Repository(this._httpClient);

  Future<List<Category>> getCategories() async {
    final db = DatabaseClient.db;
    List<Category> result;
    final local = await db.getAllCategories();
    if (local.isEmpty) {
      final remote = await categoryDataProvider.fetchCategories(_httpClient);
      db.insertCategories(remote);
      result = remote;
      print("CAT R: $remote");
    } else {
      result = local;
    }
    print("CAT L: $local");
    return Future<List<Category>>.value(result);
  }

  Future<List<Project>> getProjects(int page, int perPage) async {
    return projectDataProvider.fetchProjects(_httpClient, page, perPage);
  }

  Future<ProjectDetails> getProjectDetails(int id) async {
    return projectDataProvider.fetchProjectDetails(_httpClient, id);
  }
}
