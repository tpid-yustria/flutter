import 'package:flutter/material.dart';
import 'package:job_finder/service/api.dart';
import 'package:job_finder/models/job.dart';
import 'package:job_finder/screens/home/widgets/job_item.dart';

class SearchList extends StatefulWidget {
  SearchList({Key? key}) : super(key: key);

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
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
                padding: EdgeInsets.symmetric(vertical: 25),
                scrollDirection: Axis.vertical,
                itemCount: s,
                itemBuilder: (context, index) {
                  var _job = snapshot.data?.jobs[index];
                  print(_job);
                  return JobItem(
                    job: _job!,
                  );
                },
                separatorBuilder: (_, index) => SizedBox(
                  height: 15,
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
      child: _buildList(context),
    );


  }
}