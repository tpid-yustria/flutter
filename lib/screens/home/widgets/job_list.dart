import 'package:job_finder/service/api.dart';
import 'package:job_finder/models/job.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'job_details.dart';
import 'job_item.dart';

class JobList extends StatefulWidget {
  JobList({Key? key}) : super(key: key);

  @override
  State<JobList> createState() => _JobListState();
}

class _JobListState extends State<JobList> {
  late Future<Jobs> _jobs;
  @override
  void initState() {
    super.initState();
    _jobs = ApiService().allJob();
  }
  Widget build(BuildContext context) {

    Widget _buildList(BuildContext context) {
      return FutureBuilder(
        future: _jobs,
        builder: (context, AsyncSnapshot<Jobs> snapshot) {
          var state = snapshot.connectionState;
          dynamic s = snapshot.data?.jobs.length;
          if (state != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData) {
              return ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  scrollDirection: Axis.horizontal,
                  itemCount: s,
                  itemBuilder: (context, index) {
                    var _job = snapshot.data?.jobs[index];
                    print(_job);
                    return JobItem(
                      job: _job!,
                    );
                  },
                  separatorBuilder: (_, index) => SizedBox(
                    width: 15,
                  ),
              );

            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return Text('tes');
            }
          }
        },
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 25),
      height: 160,
      child: _buildList(context),
    );
  }
}