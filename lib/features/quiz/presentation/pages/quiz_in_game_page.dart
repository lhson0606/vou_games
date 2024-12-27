import 'package:flutter/material.dart';
import '../../../../core/widgets/dialogues/confirm_dialogue.dart';

class QuizInGamePage extends StatefulWidget {
  const QuizInGamePage({Key? key}) : super(key: key);

  @override
  _QuizInGamePageState createState() => _QuizInGamePageState();
}

class _QuizInGamePageState extends State<QuizInGamePage> {
  bool _isSoundOn = true;

  void _showConfirmDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmDialog(
          message: 'Are you sure you want to exit?',
          onConfirm: () {
            Navigator.of(context).pop(); // Close the dialog
            Navigator.of(context).pop(); // Exit the quiz page
          },
          onCancel: () {
            Navigator.of(context).pop(); // Close the dialog
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Quiz In Game'),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(_isSoundOn ? Icons.volume_up : Icons.volume_off),
                                  const SizedBox(width: 8.0),
                                  Text('Turn on sound'),
                                ],
                              ),
                              Transform.scale(
                                scale: 0.6, // Adjust the scale to make the switch smaller
                                child: Switch(
                                  value: _isSoundOn,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _isSoundOn = value;
                                    });
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                            ],
                          ),
                          const Divider(), // Add a horizontal line
                          ListTile(
                            leading: const Icon(Icons.exit_to_app),
                            title: const Text('Exit'),
                            onTap: _showConfirmDialog,
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            // First half: Question
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Quest 1/10',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Time left: 30s',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Question goes here',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16.0),
                    // Optional image
                    Image.asset(
                      'assets/question_image.png',
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ),
            // Second half: Options
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Option 1',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Option 2',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Option 3',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Option 4',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}