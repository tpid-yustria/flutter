import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:job_finder/models/job.dart';
import 'package:job_finder/screens/home/widgets/job_details.dart';
import 'icon_text.dart';

class JobItem extends StatelessWidget {
  final Job job;
  const JobItem({required this.job});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    child: Image.network(job.logo),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    job.company_name,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  child: Icon(
                      job.is_mark == false
                          ? Icons.bookmark_outline_sharp
                          : Icons.bookmark,
                      color: job.is_mark == false
                          ? Colors.grey
                          : Theme.of(context).primaryColor),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) => BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: JobDetail(job: job),
                ),
              );
            },
            child: Text(
              job.job_name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconText(
                  icon: Icons.location_on_outlined, text: job.company_address),
              // if (widget.showTime)
                IconText(
                    icon: Icons.access_time_outlined, text: job.job_type)
            ],
          ),
        ],
      ),
    );
  }
}