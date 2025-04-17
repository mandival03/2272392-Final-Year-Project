import 'package:flutter/material.dart';

class CreateFlashcardsPage extends StatefulWidget {
  final List<Map<String, dynamic>> savedBundles;
  const CreateFlashcardsPage({super.key, required this.savedBundles});

  @override
  _CreateFlashcardsPageState createState() => _CreateFlashcardsPageState();
}

class _CreateFlashcardsPageState extends State<CreateFlashcardsPage> {

  List<Map<String, String>> flashcards = [{'front': '', 'back': ''}];
  int currentIndex = 0;
  TextEditingController frontController = TextEditingController();
  TextEditingController backController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCurrentFlashcard();
  }

  void _loadCurrentFlashcard() {
    frontController.text = flashcards[currentIndex]['front'] ?? '';
    backController.text = flashcards[currentIndex]['back'] ?? '';
  }

  void _updateFlashcard() {
    flashcards[currentIndex] = {
      'front': frontController.text,
      'back': backController.text,
    };
  }

  void _addFlashcard() {
    _updateFlashcard();
    setState(() {
      flashcards.add({'front': '', 'back': ''});
      currentIndex = flashcards.length - 1;
      _loadCurrentFlashcard();
    });
  }

  void _navigateFlashcard(bool next) {
    _updateFlashcard();
    setState(() {
      if (next && currentIndex < flashcards.length - 1) {
        currentIndex++;
      } else if (!next && currentIndex > 0) {
        currentIndex--;
      }
      _loadCurrentFlashcard();
    });
  }

  void _saveFlashcards() async {
    if (flashcards.isEmpty) return;

    _updateFlashcard();

    flashcards = flashcards.where((card) {
      return card['front']!.trim().isNotEmpty || card['back']!.trim().isNotEmpty;
    }).toList();

    if (flashcards.isEmpty) return;

    showDialog(
      context: context,
      builder: (context) {
        TextEditingController bundleNameController = TextEditingController();
        return AlertDialog(
          title: Text("Enter Bundle Name"),
          content: TextField(
            controller: bundleNameController,
            decoration: InputDecoration(labelText: "Bundle Name"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                if (bundleNameController.text.isEmpty) return;

                widget.savedBundles.add({
                  'bundle_name': bundleNameController.text,
                  'flashcards': List<Map<String, String>>.from(flashcards),

                });

                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFlashcardInput(TextEditingController controller, String label) {
    return Expanded(
      child: Column(
        children: [
          Text(label, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Container(
            width: 500,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
            ),
            padding: EdgeInsets.all(20),
            child: Center(
              child: TextField(
                controller: controller,
                textAlign: TextAlign.center,
                maxLines: null,
                style: TextStyle(fontSize: 24),
                onChanged: (text) => setState(() {}),
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(title: Text('Create Flashcards')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Flashcard ${currentIndex + 1}/${flashcards.length}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, size: 40),
                  onPressed: currentIndex > 0 ? () => _navigateFlashcard(false) : null,
                ),
                _buildFlashcardInput(frontController, "Front"),
                SizedBox(width: 20),
                _buildFlashcardInput(backController, "Back"),
                IconButton(
                  icon: Icon(Icons.arrow_forward, size: 40),
                  onPressed: currentIndex < flashcards.length - 1
                      ? () => _navigateFlashcard(true)
                      : null,
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _addFlashcard, child: Text("Add Flashcard")),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _saveFlashcards, child: Text("Save Flashcards")),
          ],
        ),
      ),
    );
  }
}

class ViewFlashcardsPage extends StatefulWidget {
  final List<Map<String, dynamic>> savedBundles;
  const ViewFlashcardsPage({Key? key, required this.savedBundles}) : super(key : key);

  @override
  _ViewFlashcardsPageState createState() => _ViewFlashcardsPageState();
}

class _ViewFlashcardsPageState extends State<ViewFlashcardsPage> {
  List<Map<String, dynamic>> savedBundles = [];
  List<Map<String, dynamic>> bundles = [];

  @override
  void initState() {
    super.initState();
    _loadFlashcards();
  }

  void _loadFlashcards() {

    setState(() {
      bundles = widget.savedBundles;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('View Flashcards')),
      body: ListView.builder(
        itemCount: bundles.length,
        itemBuilder: (context, index) {
          final bundle = bundles[index];
          return ListTile(
            title: Text(bundle['bundle_name']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      FlashcardBundlePage(flashcards: List<Map<String, String>>.from(bundle['flashcards'])),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class FlashcardBundlePage extends StatefulWidget {
  final List<Map<String, String>> flashcards;
  FlashcardBundlePage({super.key, required this.flashcards});

  @override
  _FlashcardBundlePageState createState() => _FlashcardBundlePageState();
}

class _FlashcardBundlePageState extends State<FlashcardBundlePage> {
  int currentIndex = 0;
  bool showBack = false;

  void _nextFlashcard() {
    setState(() {
      if (currentIndex < widget.flashcards.length - 1) {
        currentIndex++;
        showBack = false;
      }
    });
  }

  void _prevFlashcard() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
        showBack = false;
      }
    });
  }

  void _flipCard() {
    setState(() {
      showBack = !showBack;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flashcard Viewer - Tap to flip the card')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Flashcard ${currentIndex + 1}/${widget.flashcards.length}",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: _flipCard,
            child: Container(
              width: 500,
              height: 300,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
              ),
              padding: EdgeInsets.all(20),
              child: Text(
                showBack ? widget.flashcards[currentIndex]['back']! : widget.flashcards[currentIndex]['front']!,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, size: 40),
                onPressed: _prevFlashcard,
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward, size: 40),
                onPressed: _nextFlashcard,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

