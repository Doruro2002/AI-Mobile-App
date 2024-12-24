import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterproject/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/screens/Scan.dart';
import 'Home_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  DrawerIndex _drawerIndex = DrawerIndex.HOME;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  const Color.fromARGB(255, 213, 222, 235),
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      drawer: HomeDrawer(
        screenIndex: _drawerIndex,
        iconAnimationController: AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 300),
        ),
        callBackIndex: (DrawerIndex index) {
          setState(() {
            _drawerIndex = index;
          });

          // Navigation vers les pages spécifiques
          if (index == DrawerIndex.ANN) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => AnnPage()));
          } else if (index == DrawerIndex.CNN) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => CnnPage()));
          } else if (index == DrawerIndex.About) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => AboutPage()));
          } else if (index == DrawerIndex.Logout) {
            Navigator.pushReplacementNamed(context, '/login');
          }
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                children: [
                  // Call to Action Image
                  Container(
                    padding: const EdgeInsets.all(1),
                    child: Column(
                      children: [
                        Image.asset('assets/images/home.png', height: 300), // Replace with your image asset
                      
                      ],
                    ),
                  ),
                  const SizedBox(height: 1),
                  // Main Instruction Text
                  const Text(
                    'Turn your phone into a mobile food detector in 3 Easy Steps :',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 19),
                  // Step-by-Step Instructions
                  SingleChildScrollView(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: SizedBox(
                            
                            width: 100,
                            child: buildStep(
                              context,
                              'Prepare the Fruit',
                              'assets/images/step1.png', // Replace with your image
                              'Ensure good lighting and a clear view of the fruit or veggie.',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          
                          child: buildStep(
                            
                            context,
                            'Take a Photo',
                            'assets/images/step2.png', // Replace with your image
                            'Tap "Scan Now" and capture a clear image of the plant.',
                          ),
                        ),

                        SizedBox(
                          width: 100,
                          child: buildStep(
                            context,
                            'Get Results',
                            'assets/images/step3.png', // Replace with your image
                            'Instantly receive a diagnosis with tips for treatment.',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Call to Action Button
                  // Boutons ANN et CNN
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => AnnPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.analytics, color: Colors.white),
                        Text(
                          'ANN Detection',
                          style: TextStyle(fontSize: 18, color:  Color(0xFF0F1F45)),
                        ),
                        Icon(Icons.arrow_forward, color: Colors.white),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => CnnPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0F1F45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.image, color: Colors.white),
                        Text(
                          'CNN Detection',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        Icon(Icons.arrow_forward, color: Colors.white),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
  // Step Widget
  Widget buildStep(BuildContext context, String title, String imagePath, String description) {
    return Column(
      children: [
        Image.asset(imagePath, height: 60), // Replace with your image asset
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        Text(
          description,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// Exemple de pages ANN et CNN
class AnnPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ANN Detection')),
      body: Stack(
        children: [
          // Image en arrière-plan
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              'assets/images/ANN.png', // Remplacez par le chemin de votre image
              fit: BoxFit.cover,
            ),
          ),
          // Contenu principal
          Center(
            child : Column(
                mainAxisSize: MainAxisSize.min, // Centre le contenu verticalement
              children: [
                const SizedBox(height: 540),
                // Bouton
                ElevatedButton(
                  onPressed: () {
                    // Ajoutez l'action à effectuer lors du clic sur le bouton
                      Navigator.push(context, MaterialPageRoute(builder: (_) => ScanScreen()));
                    
              
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF4D4D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 11),
                  ),
                  child: const Text(
                    'Scan Me',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CnnPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CNN Detection')),
      body: Stack (
        children: [
          // Image en arrière-plan
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              'assets/images/CNN.png', // Remplacez par le chemin de votre image
              fit: BoxFit.cover,
            ),
          ),
          // Contenu principal
          Center(
            child : Column(
                mainAxisSize: MainAxisSize.min, // Centre le contenu verticalement
              children: [
                const SizedBox(height: 540),
                // Bouton
                ElevatedButton(
                  onPressed: () {
                    // Ajoutez l'action à effectuer lors du clic sur le bouton
                      Navigator.push(context, MaterialPageRoute(builder: (_) => ScanScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F1F45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 11),
                  ),
                  child: const Text(
                    'Scan Me',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About Us')),
      body: const Center(child: Text('This is the About Us Page')),
    );
  }

  
}
