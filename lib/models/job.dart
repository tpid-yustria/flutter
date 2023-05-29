import 'package:flutter/material.dart';
import 'dart:convert';

Jobs welcomeFromJson(String str) => Jobs.fromJson(json.decode(str));

class Jobs {
  Jobs({
    required this.status,
    required this.jobs,
  });

  String status;
  List<Job> jobs;

  factory Jobs.fromJson(Map<String, dynamic> json) => Jobs(
      status: json["status"],
      jobs: List<Job>.from(
        json["jobs"].map((x) => Job.fromJson(x)).where((job) =>
        job.job_name != null &&
            job.job_type != null &&
            job.company_name != null &&
            job.company_address != null &&
            job.is_mark != null &&
            job.req != null &&
            job.logo != null),
      ));
}

class Job {
  Job({
    required this.job_name,
    required this.job_type,
    required this.company_name,
    required this.company_address,
    required this.logo,
    required this.is_mark,
    required this.req
  });

  String job_name;
  String job_type;
  String company_name;
  String company_address;
  String logo;
  bool is_mark;
  List<dynamic> req;

  factory Job.fromJson(Map<String, dynamic> json) => Job(
    job_name: json["job_name"] ?? "",
    job_type: json["job_type"] ?? "",
    company_name: json["company_name"] ?? "",
    company_address: json["company_address"] ?? "",
    logo: json["logo"] ??
        "https://cdn.nerdschalk.com/wp-content/uploads/2021/11/unknown-logo-759x427.png?width=800",
    is_mark: json["is_mark"] ?? "",
    req: json["req"] ?? "",
  );
}
