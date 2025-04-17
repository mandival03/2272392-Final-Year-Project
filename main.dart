import 'package:flutter/material.dart';
import 'package:my_maths_1/mock_paper_screen.dart';
import 'package:my_maths_1/question_service.dart';
import 'package:my_maths_1/utils/upload_training.dart';
import 'package:provider/provider.dart';
import 'question_provider.dart';
import 'question_screen.dart';
import 'flashcards.dart';
import 'teaching_notes.dart';
import 'utils/upload_training.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuestionProvider()),
      ],
      child: MathsAndMeApp(),
    ));
}

class MathsAndMeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maths&Me',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, double> _userProgress = {
    '1.1 Numbers: HCF and LCM': 0.0,
    '1.2 Numbers: Powers': 0.0,
    '1.3 Numbers: Fractions': 0.0,
    '1.4 Numbers: Ratios': 0.0,
    '1.5 Numbers: Percentages': 0.0,
    '2.1 Algebra: Equations and Formulae': 0.0,
    '2.2 Algebra: Graphs': 0.0,
    '2.3 Algebra: Simultaneous Equations': 0.0,
    '2.4 Algebra: Polynomials': 0.0,
    '3.1 Geometry: Angles': 0.0,
    '3.2 Geometry: Pythagoras Theorem': 0.0,
    '3.3 Geometry: Trigonometry': 0.0,
    '3.4 Geometry: Perimeter and Area': 0.0,
    '4.1 Statistics: Probability': 0.0,
    '4.2 Statistics: Histograms': 0.0,
  };
  List<Map<String, dynamic>> savedBundles = [];




  void _showLoginOverlay() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String email = '', password = '';

        return AlertDialog(
          title: Text('Login / Sign Up'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) => email = value,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                onChanged: (value) => password = value,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  
                },
                child: Text('Login'),
              ),
              TextButton(
                onPressed: () async {
                  
                },
                child: Text('Sign Up'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showFlashcardsOverlay() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Flashcards'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateFlashcardsPage(savedBundles: savedBundles,)),
                  );
                },
                child: Text('Create Flashcards'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewFlashcardsPage(savedBundles: savedBundles)),
                  );
                },
                child: Text('View Flashcards'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuestionProvider>(context);
    double totalProgress = provider.topicProgress.isNotEmpty
        ? provider.topicProgress.values.reduce((a, b) => a + b) / _userProgress.length
        : 0.0;

    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Maths&Me',
              style: TextStyle(
                fontSize: 70,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.topRight,
              child: FloatingActionButton(
                onPressed: _showLoginOverlay,
                child: Icon(Icons.person, color: Colors.white),
                backgroundColor: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildRoundedButton('Generate Mock Paper'),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: _buildRoundedButton('Flashcards'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),
                Container(
                  height: 20,
                  decoration: BoxDecoration(color: Colors.blue[100], borderRadius: BorderRadius.circular(10)),
                  child: ClipRRect(borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(value: totalProgress, backgroundColor: Colors.blue[100], valueColor: AlwaysStoppedAnimation<Color>(Colors.green),),
                  ),
                )
              ],
            ),


            SizedBox(height: 20,),
            Expanded(
              child: ListView(
                children: _userProgress.keys
                    .map((topic) => _buildTopicRow(topic, provider.topicProgress[topic] ?? 0.0))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoundedButton(String text, {String? topic}) {
    return ElevatedButton(
      onPressed:  () {
        if (text == 'Flashcards') {
          _showFlashcardsOverlay();
        } else if (text == 'Generate Mock Paper'){
          Navigator.push(context, MaterialPageRoute(builder: (_) => MockPaperScreen()),);

        } else if (text == 'Questions' && topic != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => QuestionScreen(topic: topic)),
          );
        } else if (text == "Learn" && topic != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TeachingNotesScreen (topic: topic)),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.symmetric(vertical: 15),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }

  Widget _buildTopicRow(String topicName, double progress) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Expanded(child: Text(topicName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
          Container(
            width: 200,
            height: 20,
            decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(5)),
            child: LinearProgressIndicator(value: progress, backgroundColor: Colors.blue[50], valueColor: AlwaysStoppedAnimation<Color>(Colors.green)),
          ),
          SizedBox(width: 10),
          Text('${(progress * 100).toInt()}%', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),
          SizedBox(width: 10),
          SizedBox(width: 100, child: _buildRoundedButton("Learn", topic: topicName),),
          SizedBox(width: 5),
          SizedBox(width: 100, child: _buildRoundedButton("Questions", topic: topicName),),
        ],
      ),
    );
  }
}