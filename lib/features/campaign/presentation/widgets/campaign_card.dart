import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:vou_games/configs/games/game_type.dart';
import 'package:vou_games/configs/lottie/app_lottie.dart';
import 'package:vou_games/features/campaign/domain/entities/campaign_entity.dart';
import 'package:vou_games/features/dice/presentation/bloc/dice_bloc.dart';
import 'package:vou_games/features/games/domain/entities/game_entity.dart';
import 'package:vou_games/features/games/presentation/bloc/game_bloc.dart';
import 'package:vou_games/features/quiz/presentation/bloc/quiz_bloc.dart';

class CampaignCard extends StatefulWidget {
  final CampaignEntity campaign;

  const CampaignCard({super.key, required this.campaign});

  @override
  State<CampaignCard> createState() => _CampaignCardState();
}

class _CampaignCardState extends State<CampaignCard> {
  String getDueTime() {
    final now = DateTime.now();
    final startDate = DateTime.parse(widget.campaign.startDate);
    final endDate = DateTime.parse(widget.campaign.endDate);

    if (now.isBefore(startDate)) {
      final duration = startDate.difference(now);
      return 'Starts in ${duration.inDays} days';
    } else if (now.isAfter(endDate)) {
      final duration = now.difference(endDate);
      return 'Ended ${duration.inDays} days ago';
    } else {
      return 'Ongoing';
    }
  }

  bool isJoinable() {
    final now = DateTime.now();
    final startDate = DateTime.parse(widget.campaign.startDate);
    final endDate = DateTime.parse(widget.campaign.endDate);
    return now.isAfter(startDate) && now.isBefore(endDate);
  }

  bool isLoadingGameTypes = false;
  bool hasErrorWhenLoadingCampaignGames = false;
  List<GameEntity> games = [];

  @override
  void initState() {
    super.initState();
    context.read<GameBloc>().add(GetCampaignGamesEvent(widget.campaign.id));
  }

  void _showGameTypeBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.5,
          // Adjust this value to cover half or one-third of the screen
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16.0)),
            ),
            child: Column(
              children: [
                GestureDetector(
                  onVerticalDragDown: (_) => Navigator.pop(context),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    width: 40.0,
                    height: 4.0,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Select Game Type',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: games.map((game) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: ListTile(
                          leading: Lottie.asset(
                              AppLottie.getPath(game.gameType.name),
                              width: 40.0),
                          title: Center(child: Text(game.gameType.name)),
                          onTap: () {
                            if (game.gameType.name == real_time_quiz_string) {
                              context.read<QuizBloc>().add(PlayQuizEvent(
                                  campaignId: widget.campaign.id,
                                  gameId: game.id,
                                  startAt: game.startAt ?? DateTime.now()));
                            } else if (game.gameType.name == roll_dice_string) {
                              context.read<DiceBloc>().add(PlayDiceEvent(
                                  campaignId: widget.campaign.id,
                                  gameId: game.id));
                            }

                            // close the bottom sheet
                            Navigator.pop(context);
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context)
          .colorScheme
          .inversePrimary, // Use theme color for background
      elevation: 4.0,
      margin: const EdgeInsets.all(8.0),
      child: BlocListener<GameBloc, GameState>(
        listener: (context, state) {
          if (state is CampaignGamesLoadedState &&
              state.campaignId == widget.campaign.id) {
            setState(() {
              games = state.games;
              isLoadingGameTypes = false;
            });
          } else if (state is CampaignGamesLoadingState &&
              state.campaignId == widget.campaign.id) {
            setState(() {
              isLoadingGameTypes = true;
            });
          } else if (state is CampaignGamesErrorState &&
              state.campaignId == widget.campaign.id) {
            setState(() {
              hasErrorWhenLoadingCampaignGames = true;
              isLoadingGameTypes = false;
            });
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(
              widget.campaign.imageUrl,
              width: double.infinity,
              height: 200.0,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      widget.campaign.name,
                      softWrap: true,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: isJoinable()
                        ? () {
                            _showGameTypeBottomSheet(context);
                          }
                        : null,
                    child: const Text('Join'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                getDueTime(),
                style: const TextStyle(fontSize: 14.0),
              ),
            ),
            if (hasErrorWhenLoadingCampaignGames)
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Flexible(
                        child: Text(
                          'Error loading games',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: () {
                          setState(() {
                            hasErrorWhenLoadingCampaignGames = false;
                          });
                          context
                              .read<GameBloc>()
                              .add(GetCampaignGamesEvent(widget.campaign.id));
                        },
                      ),
                    ],
                  ))
            else if (isLoadingGameTypes)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: LinearProgressIndicator(),
              )
            else
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  spacing: 4.0,
                  runSpacing: 4.0,
                  children: games.map((game) {
                    Color chipColor;
                    switch (game.gameType.name) {
                      case roll_dice_string:
                        chipColor = Colors.blue;
                        break;
                      case real_time_quiz_string:
                        chipColor = Colors.green;
                        break;
                      default:
                        chipColor = Colors.grey;
                    }
                    return Chip(
                      label: Text(
                        game.gameType.name,
                        style: const TextStyle(fontSize: 12.0),
                      ),
                      shape: StadiumBorder(
                        side: BorderSide(color: chipColor),
                      ),
                      backgroundColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                    );
                  }).toList(),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                widget.campaign.description,
                style: const TextStyle(fontSize: 14.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      const Icon(Icons.location_pin),
                      Text(widget.campaign.location),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color:
                              widget.campaign.liked ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          // Handle like button press
                        },
                      ),
                      Text(
                        widget.campaign.status == 'active'
                            ? '${widget.campaign.likesCount} likes'
                            : '${widget.campaign.participantsCount} participants',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
