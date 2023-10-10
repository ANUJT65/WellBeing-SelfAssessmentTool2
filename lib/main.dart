import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserInfoPage(),
    );
  }
}

class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  String name = '';
  int age = 0;
  String gender = '';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Information'),
        backgroundColor: Colors.purple,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'अपना नाम दर्ज करें',
                  labelStyle: TextStyle(color: Colors.white), // Color of the label text
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple), // Color of the border
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple), // Color of the focused border
                  ),
                ),
                style: TextStyle(color: Colors.white), // Color of the input text
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'कृपया अपना नाम दर्ज करें';
                  }
                  return null;
                },
                onSaved: (value) {
                  name = value!;
                },
              ),
              SizedBox(height: 20.0),

              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'अपनी आयु दर्ज करें',
                  labelStyle: TextStyle(color: Colors.white), // Color of the label text
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple), // Color of the border
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple), // Color of the focused border
                  ),
                ),
                style: TextStyle(color: Colors.white), // Color of the input text
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'कृपया अपनी आयु दर्ज करें:';
                  }
                  return null;
                },
                onSaved: (value) {
                  age = int.tryParse(value!) ?? 0;
                },
              ),
              SizedBox(height: 20.0),

              TextFormField(
                decoration: InputDecoration(
                  labelText: 'अपना लिंग दर्ज करें',
                  labelStyle: TextStyle(color: Colors.white), // Color of the label text
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple), // Color of the border
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple), // Color of the focused border
                  ),
                ),
                style: TextStyle(color: Colors.white), // Color of the input text
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'कृपया अपना लिंग दर्ज करें';
                  }
                  return null;
                },
                onSaved: (value) {
                  gender = value!;
                },
              ),

              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SurveyPage(age, name, gender),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple, // Change button color here
                ),
                child: Text('आगे'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SurveyPage extends StatefulWidget {
  final int age;
  final String name;
  final String gender;

  SurveyPage(this.age, this.name, this.gender);

  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  late List<String> questions;
  List<int> userResponses = [];

  @override
  void initState() {
    super.initState();
    if (widget.age <= 13) {
      questions = [
        "क्या आपको आज किसी स्थिति या बात के बारे में चिंता है? (1: पूरी तरह असहमत, 2: असहमत, 3: नकारात्मक, 4: सहमत, 5: पूरी तरह सहमत)",

            "क्या आपको आपके माता-पिता की तरफ से कोई दबाव महसूस होता है? (1: पूरी तरह असहमत, 2: असहमत, 3: नकारात्मक, 4: सहमत, 5: पूरी तरह सहमत)",

            "क्या आपको किसी वजह से आत्महत्या या बुरे विचार आए हैं? (1: पूरी तरह असहमत, 2: असहमत, 3: नकारात्मक, 4: सहमत, 5: पूरी तरह सहमत)",

            "क्या आपको सोने के समय या सुबह उठते समय अच्छा नहीं लगता? (1: पूरी तरह असहमत, 2: असहमत, 3: नकारात्मक, 4: सहमत, 5: पूरी तरह सहमत)",

            "क्या आपको आपके दोस्तों और संबंधितों के साथ कोई समस्या है? (1: पूरी तरह असहमत, 2: असहमत, 3: नकारात्मक, 4: सहमत, 5: पूरी तरह सहमत)",
             "क्या आपका दिन आज अच्छा या बुरा था? (1: पूरी तरह बुरा, 2: बुरा, 3: नकारात्मक, 4: अच्छा, 5: पूरी तरह अच्छा)",

            "क्या आपको पढ़ाई में कोई अत्यधिक दबाव महसूस हो रहा है? (1: पूरी तरह असहमत, 2: असहमत, 3: नकारात्मक, 4: सहमत, 5: पूरी तरह सहमत)",

            "क्या आपको लगता है कि आपके विचारों और भावनाओं को समझा जाता है? (1: पूरी तरह असहमत, 2: असहमत, 3: नकारात्मक, 4: सहमत, 5: पूरी तरह सहमत)",

            "क्या आपको सोशल मीडिया या इंटरनेट के इस्तेमाल से संबंधित कोई चिंता है? (1: पूरी तरह असहमत, 2: असहमत, 3: नकारात्मक, 4: सहमत, 5: पूरी तरह सहमत)",

            "क्या आपको महसूस होता है कि आपके परिवार आपके प्रति आदर्श या उम्मीदें रखते हैं? (1: पूरी तरह असहमत, 2: असहमत, 3: नकारात्मक, 4: सहमत, 5: पूरी तरह सहमत)"

      ];
    } else {
      questions = [
        "On a scale of 1-5, how often do you feel anxious? (1: Rarely, 5: Very often)",
        "On a scale of 1-5, how often do you feel stressed? (1: Rarely, 5: Very often)",
        "On a scale of 1-5, how often do you feel sad or down? (1: Rarely, 5: Very often)"
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Survey'),
        backgroundColor: Colors.purple,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              ' ${widget.name},कृपया निम्नलिखित प्रश्नों का उत्तर दें:',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            SizedBox(height: 20.0),
            ...questions.asMap().entries.map(
                  (entry) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    entry.value,
                    style: TextStyle(color: Colors.white),  // Text color to white
                  ),
                  Slider(
                    value: userResponses.length > entry.key ? userResponses[entry.key].toDouble() : 3.0,
                    onChanged: (value) {
                      setState(() {
                        if (userResponses.length > entry.key) {
                          userResponses[entry.key] = value.toInt();
                        } else {
                          userResponses.add(value.toInt());
                        }
                      });
                    },
                    min: 1,
                    max: 5,
                    divisions: 4,
                    label: userResponses.length > entry.key ? userResponses[entry.key].toString() : '3',
                    activeColor: Colors.purple,  // Set active color to purple
                    inactiveColor: Colors.purple.withOpacity(0.3),  // Set inactive color to a lighter shade of purple
                  ),

                ],
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultsPage(userResponses, widget.name, widget.age, widget.gender),
                  ),
                );
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultsPage extends StatelessWidget {
  final List<int> userResponses;
  final String name;
  final int age;
  final String gender;

  ResultsPage(this.userResponses, this.name, this.age, this.gender);

  String generateEmailBody() {
    String assessmentResults = '''
    Assessment Results:
    User responses: ${userResponses.join(', ')}
    Name: $name
    Age: $age
    Gender: $gender
    ''';

    return Uri.encodeComponent(assessmentResults);
  }

  void sendEmail() async {
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: '', // Add recipient's email here
      query: 'subject=Assessment Results&body=${generateEmailBody()}',
    );
    if (await canLaunch(_emailLaunchUri.toString())) {
      await launch(_emailLaunchUri.toString());
    } else {
      throw 'Could not launch email';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assessment Results'),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: AssessmentResultsChart(userResponses, name, age, gender),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: sendEmail,
        child: Icon(Icons.email),
      ),
    );
  }
}

class AssessmentResultsChart extends StatelessWidget {
  final List<int> userResponses;
  final String name;
  final int age;
  final String gender;

  AssessmentResultsChart(this.userResponses, this.name, this.age, this.gender);

  @override
  Widget build(BuildContext context) {
    // Calculate the percentage based on user responses (1-5)
    double percentage = (userResponses.reduce((a, b) => a + b) / (userResponses.length * 5)) * 100;

    // Calculate the frequency of each response (1-5)
    Map<int, int> responseCounts = calculateResponseCounts(userResponses);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'मूल्यांकन परिणाम \n उच्च ग्रेड = अधिक तीव्रता',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 20),
              Container(
                height: 400.0,
                color: Colors.black,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: userResponses.length > 0 ? userResponses.length.toDouble() : 1,
                    minY: 1, // Change min value to 1
                    groupsSpace: 12,
                    titlesData: FlTitlesData(
                      leftTitles: SideTitles(showTitles: true, reservedSize: 22),
                      bottomTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 50,
                        getTextStyles: (context, value) => const TextStyle(color: Colors.white, fontSize: 14),
                        getTitles: (double value) {
                          return value.toInt().toString();
                        },
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    barGroups: [
                      BarChartGroupData(
                        x: 1,
                        barRods: [
                          BarChartRodData(
                            y: responseCounts[1]!.toDouble(),
                            width: 22,
                            colors: [Colors.blue],
                          ),
                        ],
                        showingTooltipIndicators: [0],
                      ),
                      BarChartGroupData(
                        x: 2,
                        barRods: [
                          BarChartRodData(
                            y: responseCounts[2]!.toDouble(),
                            width: 22,
                            colors: [Colors.red],
                          ),
                        ],
                        showingTooltipIndicators: [0],
                      ),
                      BarChartGroupData(
                        x: 3,
                        barRods: [
                          BarChartRodData(
                            y: responseCounts[3]!.toDouble(),
                            width: 22,
                            colors: [Colors.green],
                          ),
                        ],
                        showingTooltipIndicators: [0],
                      ),
                      BarChartGroupData(
                        x: 4,
                        barRods: [
                          BarChartRodData(
                            y: responseCounts[4]!.toDouble(),
                            width: 22,
                            colors: [Colors.yellow],
                          ),
                        ],
                        showingTooltipIndicators: [0],
                      ),
                      BarChartGroupData(
                        x: 5,
                        barRods: [
                          BarChartRodData(
                            y: responseCounts[5]!.toDouble(),
                            width: 22,
                            colors: [Colors.redAccent],
                          ),
                        ],
                        showingTooltipIndicators: [0],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                '             उपयोगकर्ता की प्रतिक्रियाएँ 1 से 5 तक\n\n\n'
                    'Patient Information:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 10.0),
              Text(
                'नाम: $name',
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
              Text(
                'आयु: $age',
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
              Text(
                'लिंग: $gender',
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
              SizedBox(height: 10.0),
              Text(
                'डिप्रेशन प्रतिशत: $percentage%',
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Map<int, int> calculateResponseCounts(List<int> responses) {
    Map<int, int> counts = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
    for (int response in responses) {
      counts[response] = (counts[response] ?? 0) + 1;
    }
    return counts;
  }
}
