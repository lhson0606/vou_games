import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vou_games/core/widgets/display/snack_bar.dart';
import 'package:vou_games/features/campaign/presentation/bloc/campaign_bloc.dart';

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: Icon(Icons.clear),
                  hintText: 'Search campaigns',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: BlocConsumer<CampaignBloc, CampaignState>(
                builder: (context, state) {
                  if (state is UpcomingCampaignLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is UpcomingCampaignLoadedState) {
                    return ListView.builder(
                      itemCount: state.campaignList.length,
                      itemBuilder: (context, index) {
                        final campaign = state.campaignList[index];
                        return ListTile(
                          title: Text(campaign.name),
                          subtitle: Text(campaign.description),
                        );
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
                },
                listener: (context, state) {
                  if (state is UpcomingCampaignErrorState) {
                    showSnackBar(context, state.error,
                        type: SnackBarType.error);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}