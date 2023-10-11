import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:pitarata_job/providers/all_provider.dart';
import 'package:provider/provider.dart';
import '../api/api_deatails.dart';

class Api {
  getWallpaper(BuildContext context) async {
    var headers = {'Content-Type': 'application/json'};
    var response =
        await http.post(Uri.parse('$apiUrl/getHomeWallpapers'), headers: headers, body: json.encode({"app_id": "nzone_4457Was555@qsd_job"}));
    var res = jsonDecode(response.body.toString());
    List img = res['data'];
    print(img);

    if (img.isNotEmpty) {
      Provider.of<AppProvider>(context, listen: false).wallPaper = img;
    }
  }

  getCategory(BuildContext context) async {
    var headers = {'Content-Type': 'application/json'};

    // request.headers.addAll(headers);
    var response = await http.post(Uri.parse('$apiUrl/getCategory'),
        headers: headers, body: json.encode({"app_id": "nzone_4457Was555@qsd_job"}));
    var res = jsonDecode(response.body.toString());

    List cat = [
      {"category_id": "0", "category_name": "All"}
    ];

    Provider.of<AppProvider>(context, listen: false).serchCategory = res['data'];
    print(res['data']);
    cat.addAll(res['data']);

    Provider.of<AppProvider>(context, listen: false).categoryList = cat;
  }

  getJobCategory(BuildContext context) async {
    var headers = {'Content-Type': 'application/json'};
    // request.headers.addAll(headers);
    var response = await http.post(Uri.parse('$apiUrl/getJobsToHome'),
        headers: headers, body: json.encode({"app_id": "nzone_4457Was555@qsd_job", "category_id": '0', "from": 0, "to": "50"}));
    var res = jsonDecode(response.body.toString());
    print(res['data']);
    // if (res['data'].toString() == "[]") {
    // } else {}

    Provider.of<AppProvider>(context, listen: false).getJobs = res['data'];
    // isLoading = false;
  }
}
