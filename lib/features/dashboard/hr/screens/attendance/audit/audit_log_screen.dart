import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/features/dashboard/hr/screens/attendance/audit/audit_log_provider.dart';
import 'package:hrms_yb/shared/utils/app_text_style.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';
import 'package:provider/provider.dart';

class AuditLogScreen extends StatefulWidget {
  const AuditLogScreen({super.key});

  @override
  State<AuditLogScreen> createState() => _AuditLogScreenState();
}

class _AuditLogScreenState extends State<AuditLogScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuditLogProvider(context: context),
      child: Consumer<AuditLogProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              leading: CommonWidget().backButton(onTap: () => context.pop()),
              title: Text(
                "Audit Log",
                style: AppTextStyle().titleTextStyle(context: context, color: AppColors.whiteColor),
              ),
            ),
            body: SafeArea(
              child: _buildBody(context: context, provider: provider),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody({required BuildContext context, required AuditLogProvider provider}) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.all(0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: provider.dummyCorrections.length,
                itemBuilder: (context, index) {
                  return AttendanceCorrectionCard(data: provider.dummyCorrections[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AttendanceCorrectionCard extends StatelessWidget {
  final AttendanceCorrection data;

  const AttendanceCorrectionCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      padding: EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: data.accentColor, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),

          /// Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(data.name, style: AppTextStyle().titleTextStyle(context: context)),
              Text(data.dateTime, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
            ],
          ),

          const SizedBox(height: 4),
          Text(data.employeeId, style: AppTextStyle().lableTextStyle(context: context)),
          const SizedBox(height: 12),

          /// Highlight Box
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: data.accentColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  style: AppTextStyle().titleTextStyle(context: context, color: data.accentColor),
                ),
                const SizedBox(height: 10),
                Text(
                  data.description,
                  style: AppTextStyle().lableTextStyle(context: context, color: data.accentColor),
                ),
                const SizedBox(height: 8),
                Text(
                  data.reason,
                  style: AppTextStyle().lableTextStyle(context: context, color: data.accentColor),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
