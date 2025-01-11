import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vou_games/core/widgets/display/snack_bar.dart';
import 'package:vou_games/features/campaign/presentation/bloc/campaign_bloc.dart';
import 'package:vou_games/features/campaign/presentation/widgets/campaign_card.dart';

import '../../../../configs/svg/app_vectors.dart';

class CampaignHomePage extends StatefulWidget {
  const CampaignHomePage({super.key});

  @override
  CampaignHomePageState createState() => CampaignHomePageState();
}

class CampaignHomePageState extends State<CampaignHomePage> {
  @override
  void initState() {
    super.initState();
    // Emit the event to get upcoming campaigns
    context.read<CampaignBloc>().add(GetUpComingCampaignEvent());
  }

  Timer? _debounce;

  void searchCampaigns(String term) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(seconds: 1), () {
      if (term.isEmpty) {
        context.read<CampaignBloc>().add(GetUpComingCampaignEvent());
      } else {
        context.read<CampaignBloc>().add(SearchCampaignEvent(term));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        child: Scaffold(
          body: Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 175 / 53, // Adjust the aspect ratio as needed
                child: SvgPicture.asset(
                  AppVectors.campaign_homepage_bg,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: Icon(Icons.clear),
                      hintText: 'Search campaigns',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (term) {
                      searchCampaigns(term);
                    }),
              ),
              Expanded(
                child: BlocConsumer<CampaignBloc, CampaignState>(
                  builder: (context, state) {
                    if (state is LoadingCampaignState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is CampaignsLoadedState) {
                      return ListView.builder(
                        itemCount: state.campaignList.length,
                        itemBuilder: (context, index) {
                          final campaign = state.campaignList[index];
                          return CampaignCard(campaign: campaign);
                        },
                      );
                    } else if (state is LoadingCampaignErrorState) {
                      return Center(
                        child: Text(state.error),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                  listener: (context, state) {
                    if (state is LoadingCampaignErrorState) {
                      showSnackBar(context, state.error,
                          type: SnackBarType.error);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
