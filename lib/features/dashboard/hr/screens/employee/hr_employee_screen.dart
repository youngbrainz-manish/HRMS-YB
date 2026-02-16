import 'package:flutter/material.dart';

class HrEmployeeScreen extends StatelessWidget {
  const HrEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _buildBody(context: context)),
    );
  }

  Widget _buildBody({required BuildContext context}) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(child: Text("HrEmployeeScreen")),
    );
  }
}
