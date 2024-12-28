import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vou_games/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:vou_games/features/notification/presentation/widgets/notification_item.dart';
import 'package:vou_games/core/widgets/display/loading_widget.dart';

class NotificationHomepage extends StatefulWidget {
  const NotificationHomepage({super.key});

  @override
  State<NotificationHomepage> createState() => _NotificationHomepageState();
}

class _NotificationHomepageState extends State<NotificationHomepage> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationBloc>().add(FetchNotificationEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is FetchingNotificationState) {
            return const Center(child: LoadingWidget());
          } else if (state is NotificationLoadedState) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Total Notifications: ${state.notifications.length}'),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.notifications.length,
                    itemBuilder: (context, index) {
                      return NotificationItem(notification: state.notifications[index]);
                    },
                  ),
                ),
              ],
            );
          } else if (state is NotificationErrorState) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return const Center(child: Text('No notifications available.'));
        },
      ),
    );
  }
}