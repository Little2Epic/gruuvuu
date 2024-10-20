import 'package:flutter/material.dart';

class DailyPage extends StatelessWidget {
  const DailyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.purpleAccent,
      child: Center(
        child: Text(
          'Daily Page',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
