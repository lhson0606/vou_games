import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vou_games/configs/navigation/destination_indices.dart';
import 'package:vou_games/core/widgets/display/custom_navigation_bar.dart';
import 'package:vou_games/core/widgets/display/loading_widget.dart';
import 'package:vou_games/core/widgets/display/snack_bar.dart';
import 'package:vou_games/features/authentication/presentation/pages/auth/sign_in_page.dart';
import 'package:vou_games/features/campaign/presentation/bloc/campaign_bloc.dart';
import 'package:vou_games/features/homepage/presentation/bloc/homepage_navigator_bloc.dart';
import 'package:vou_games/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:vou_games/features/quiz/presentation/bloc/quiz_bloc.dart';
import 'package:vou_games/features/shop/presentation/bloc/shop_bloc.dart';
import 'package:vou_games/features/user/presentation/bloc/user_bloc.dart';
import 'package:vou_games/features/voucher/presentation/bloc/voucher_state.dart';

import '../../../authentication/presentation/bloc/auth_bloc.dart';
import '../../../voucher/presentation/bloc/voucher_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<CustomBottomNavigationBarState> bottomNavigationBarKey =
      GlobalKey<CustomBottomNavigationBarState>();

  final List<Destination> allDestinations = <Destination>[
    const Destination(
        CAMPAIGN_HOMEPAGE_INDEX, 'Campaign', Icons.event, Colors.cyan),
    const Destination(VOUCHER_HOMEPAGE_INDEX, 'Voucher',
        Icons.discount_outlined, Colors.orange),
    const Destination(
        SHOP_HOMEPAGE_INDEX, 'Shop', Icons.location_pin, Colors.orange),
    const Destination(NOTIFICATION_HOMEPAGE_INDEX, 'Notification',
        Icons.notifications, Colors.blue),
    const Destination(
        USER_HOMEPAGE_INDEX, 'User', Icons.person, Colors.green),
  ];

  Widget currentScreen = const LoadingWidget();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final bloc = context.read<HomepageNavigatorBloc>();
    for (var destination in allDestinations) {
      // add the destination to the bloc
      bloc.add(AddDestinationEvent(destination));
    }
    bloc.add(LoadFirstScreenEvent());
  }

  void _onBottomBarIndexChanged(int index) {
    if (kDebugMode) {
      print(index.toString());
    }
    switch (index) {
      case CAMPAIGN_HOMEPAGE_INDEX:
        context
            .read<CampaignBloc>()
            .add(RequestNavigateToCampaignHomepageEvent());
        break;
      case VOUCHER_HOMEPAGE_INDEX:
        context
            .read<VoucherBloc>()
            .add(RequestNavigateToVoucherHomepageEvent());
        break;
      case SHOP_HOMEPAGE_INDEX:
        context.read<ShopBloc>().add(RequestNavigateToShopHomepageEvent());
        break;
      case NOTIFICATION_HOMEPAGE_INDEX:
        context
            .read<NotificationBloc>()
            .add(RequestNavigateToNotificationHomepageEvent());
        break;
      case USER_HOMEPAGE_INDEX:
        context.read<UserBloc>().add(RequestNavigateToUserHomepageEvent());
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    bottomNavigationBarKey.currentState?.onIndexChanged
        .remove(_onBottomBarIndexChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoggedOutState) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const SignIn()));
          } else if (state is AuthErrorState) {
            final errorMessage = state.message;
            showSnackBar(context, errorMessage, type: SnackBarType.error);
          } else if (state is AuthLoadingLoggedOutState) {
            showSnackBar(context, "Logging out...", type: SnackBarType.info);
          }
        },
        child: MultiBlocListener(
          listeners: [
            BlocListener<CampaignBloc, CampaignState>(
                listener: (context, state) {
              if (state is RequestNavigateToCampaignHomepageState) {
                context
                    .read<HomepageNavigatorBloc>()
                    .add(ChangeHomepageCurrentScreenEvent(state.homepage));
              }
            }),
            BlocListener<VoucherBloc, VoucherState>(
                listener: (context, state) {
              if (state is RequestNavigateToVoucherHomepageState) {
                context
                    .read<HomepageNavigatorBloc>()
                    .add(ChangeHomepageCurrentScreenEvent(state.homepage));
              }
            }),
            BlocListener<ShopBloc, ShopState>(listener: (context, state) {
              if (state is RequestNavigateToShopHomepageState) {
                context
                    .read<HomepageNavigatorBloc>()
                    .add(ChangeHomepageCurrentScreenEvent(state.homepage));
              }
            }),
            BlocListener<NotificationBloc, NotificationState>(
                listener: (context, state) {
              if (state is RequestNavigateToNotificationHomepageState) {
                context
                    .read<HomepageNavigatorBloc>()
                    .add(ChangeHomepageCurrentScreenEvent(state.homepage));
              }
            }),
            BlocListener<UserBloc, UserState>(listener: (context, state) {
              if (state is RequestNavigateToUserHomepageState) {
                context
                    .read<HomepageNavigatorBloc>()
                    .add(ChangeHomepageCurrentScreenEvent(state.homepage));
              }
            }),
            BlocListener<QuizBloc, QuizState> (listener: (context, state) {
              if(state is RequestNavigateToQuizState) {
                context.read<HomepageNavigatorBloc>().add(NavigationEvent(state.quizPage));
              }
            },),
            BlocListener<HomepageNavigatorBloc, HomepageNavigatorState>(
                listener: (context, state) {
                  // if (state is HomepageNavigatorInitialState) {
                  //   context
                  //       .read<CampaignBloc>()
                  //       .add(RequestNavigateToCampaignHomepageEvent());
                  // } else
                  if (state is AddDestinationState) {
                    bottomNavigationBarKey.currentState!
                        .addDestination(state.destination);
                  } else if (state is HomepageNavigatorChangeCurrentScreenState) {
                    setState(() {
                      currentScreen = state.screen;
                    });
                  } else if (state is LoadFirstScreenState) {
                    context
                        .read<CampaignBloc>()
                        .add(RequestNavigateToCampaignHomepageEvent());
                    bottomNavigationBarKey.currentState?.onIndexChanged
                        .add(_onBottomBarIndexChanged);
                  } else if (state is PageChangedState) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => state.page)
                    );
                  }
                }),
          ],
          child: Scaffold(
            body: Center(
              child: currentScreen,
            ),
            bottomNavigationBar:
                CustomBottomNavigationBar(key: bottomNavigationBarKey),
          ),
        ),
      ),
    );
  }
}
