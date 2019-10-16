import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:creative_run/model/project.dart';
import 'package:creative_run/model/project_details.dart';
import 'package:creative_run/model/stats.dart';
import 'package:http/http.dart';

const originalImageKey = "original";

Future<List<Project>> fetchProjects(
    Client httpClient, int page, int perPage) async {
  final response =
      await httpClient.get("v2/projects?page=$page&per_page=$perPage");
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final projectsData = data["projects"] as List;
    return projectsData.map(_mapProject).toList();
  } else {
    throw Exception('error fetching projects');
  }
}

Future<ProjectDetails> fetchProjectDetails(Client httpClient, int id) async {
  final response = await httpClient.get("v2/projects/$id");
  print(id);
  print(response.body);
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final projectData = data["project"];
    final covers = projectData["covers"];
    return ProjectDetails(
      projectData["id"],
      projectData["name"],
      _getDate(projectData),
      projectData["url"],
      _getCategories(projectData),
      _getBiggerImage(covers),
      _getSmallerImage(covers),
      _getStats(projectData),
      _getColor(projectData),
      projectData["description"],
      [],
    );
  } else {
    throw Exception('error fetching project details');
  }
}

Project _mapProject(projectData) {
  final covers = projectData["covers"];
  return Project(
    projectData["id"],
    projectData["name"],
    _getDate(projectData),
    projectData["url"],
    _getCategories(projectData),
    _getBiggerImage(covers),
    _getSmallerImage(covers),
    _getStats(projectData),
    _getColor(projectData),
  );
}

Stats _getStats(dynamic projectData) {
  final statsData = projectData["stats"];
  return Stats(
      statsData["views"], statsData["appreciations"], statsData["comments"]);
}

DateTime _getDate(dynamic projectData) {
  return DateTime.fromMillisecondsSinceEpoch(projectData["created_on"] * 1000);
}

List<String> _getCategories(dynamic projectData) {
  return (projectData["fields"] as List).cast<String>();
}

String _getBiggerImage(Map<String, dynamic> covers) {
  if (covers.containsKey(originalImageKey)) {
    return covers[originalImageKey];
  } else {
    return _getImage(covers, max);
  }
}

String _getSmallerImage(Map<String, dynamic> covers) {
  return _getImage(covers, min);
}

String _getImage(Map<String, dynamic> covers, Function(int, int) minMax) {
  final sizes = covers.keys
      .map((key) {
        return int.tryParse(key);
      })
      .where((key) => key != null)
      .toList();
  if (sizes.isEmpty) {
    return null;
  }
  final key = sizes.reduce(minMax).toString();
  return covers[key];
}

Color _getColor(dynamic projectData) {
  final colorsData = projectData["colors"] as List;
  final colorData = colorsData.length > 0 ? colorsData.elementAt(0) : null;
  return colorData != null
      ? Color.fromRGBO(colorData["r"], colorData["g"], colorData["b"], 1)
      : Color.fromRGBO(0, 0, 0, 0);
}
