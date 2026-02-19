import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_yb/core/theme/app_colors.dart';
import 'package:hrms_yb/shared/notification/notification_provider.dart';
import 'package:hrms_yb/shared/widgets/common_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NotificationProvider(context: context),
      child: Consumer<NotificationProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              leading: CommonWidget().backButton(onTap: () => context.pop()),
              title: const Text("Notifications"),
              centerTitle: true,
            ),
            body: _buildBody(context: context, provider: provider),
          );
        },
      ),
    );
  }

  ListView _buildBody({required BuildContext context, required NotificationProvider provider}) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: provider.notifications.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final data = provider.notifications[index];
        return NotificationTile(data: data);
      },
    );
  }
}

class NotificationTile extends StatelessWidget {
  final HrNotification data;

  const NotificationTile({super.key, required this.data});

  IconData _iconByType(String type) {
    switch (type) {
      case "leave":
        return Icons.event_available;
      case "attendance":
        return Icons.access_time;
      case "salary":
        return Icons.account_balance_wallet;
      default:
        return Icons.notifications;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          // color: data.isRead ? AppColors.whiteColor : AppColors.textButtonColor.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderGrey),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: AppColors.textButtonColor.withValues(alpha: .1),
              child: Icon(_iconByType(data.type), color: AppColors.textButtonColor),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title
                  Text(
                    data.title,
                    style: TextStyle(fontWeight: data.isRead ? FontWeight.w500 : FontWeight.bold, fontSize: 15),
                  ),

                  const SizedBox(height: 4),

                  /// Message
                  Text(data.message, style: TextStyle(color: AppColors.greyColor, fontSize: 13)),

                  const SizedBox(height: 8),

                  /// Time
                  Text(
                    DateFormat('dd MMM • hh:mm a').format(data.time),
                    style: TextStyle(fontSize: 12, color: AppColors.greyColor),
                  ),
                ],
              ),
            ),

            /// Unread Dot
            if (!data.isRead)
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(color: AppColors.textButtonColor, shape: BoxShape.circle),
              ),
          ],
        ),
      ),
    );
  }
}
