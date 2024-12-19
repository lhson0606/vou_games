import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vou_games/configs/navigation/destination_indices.dart';
import 'package:vou_games/core/services/navigation_service.dart';
import 'package:vou_games/core/widgets/display/custom_navigation_bar.dart';
import 'package:vou_games/core/widgets/display/loading_widget.dart';
import 'package:vou_games/core/widgets/display/snack_bar.dart';
import 'package:vou_games/features/authentication/presentation/pages/auth/sign_in_page.dart';
import 'package:vou_games/features/campaign/presentation/bloc/campaign_bloc.dart';
import 'package:vou_games/features/campaign/presentation/pages/campaign_homepage.dart';
import 'package:vou_games/features/homepage/presentation/bloc/homepage_navigator_bloc.dart';
import 'package:vou_games/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:vou_games/features/shop/presentation/bloc/shop_bloc.dart';
import 'package:vou_games/features/user/presentation/bloc/user_bloc.dart';
import 'package:vou_games/features/voucher/presentation/bloc/voucher_state.dart';
import 'package:vou_games/injection_container.dart' as di;

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

  Widget currentScreen = const Text('Loading...');

  void _onBottomBarIndexChanged(int index) {
    print(index.toString());
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

          ],
          child: Scaffold(
            body: Center(
              child: currentScreen,
            ),
            bottomNavigationBar:
                BlocConsumer<HomepageNavigatorBloc, HomepageNavigatorState>(
                    builder: (context, state) {
              if (state is HomepageNavigatorInitialState) {
                return CustomBottomNavigationBar(key: bottomNavigationBarKey);
              } else if (state is ChangeHomePageNavigatorVisibilityState) {
                if (!state.isVisible) {
                  return const SizedBox();
                }
              }
              return CustomBottomNavigationBar(key: bottomNavigationBarKey);
            }, listener: (context, state) {
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
              }
            }),
          ),
        ),
      ),
    );
  }
}
