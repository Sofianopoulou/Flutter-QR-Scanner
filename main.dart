import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Coca Cola card',
      home: MyStatefulWidget(),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.displayMedium!.copyWith(
      fontWeight: FontWeight.bold,
      color: theme.colorScheme.onPrimary,
    );

    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: const Color(0xFFebf2fb),
        ),
        child: Padding(
          padding: const EdgeInsets.all(100.0),
          child: Card(
            clipBehavior: Clip.antiAlias,
            elevation: 7.0,
            color: Colors.white,
            shadowColor: Colors.purple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: SizedBox(
              /*width: MediaQuery.of(context).size.height * 0.3,
              height: MediaQuery.of(context).size.width * 0.8,*/
              width: 350,
              height: 160,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            'https://cdn.shopify.com/s/files/1/1576/9979/products/CokeClassic_1334x.png?v=1594914369',
                          ),
                          radius: 50,
                          backgroundColor: Color(0xFFebf2fb),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Text(
                          "Coca-Cola",
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          '0/10',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AppBarExample extends StatelessWidget implements PreferredSizeWidget {
  const AppBarExample({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = TextButton.styleFrom(
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(144, 12, 63, 100),
        actions: <Widget>[
          TextButton(
            style: style,
            onPressed: () {},
            child: const Text('New Product'),
          ),
          TextButton(
            style: style,
            onPressed: () {},
            child: const Text('Favorites'),
          ),
        ],
      ),
    );
  }
}

class DrawerExample extends StatelessWidget {
  const DrawerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarExample(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration:
                  BoxDecoration(color: Color.fromRGBO(144, 12, 63, 100)),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.message),
              title: const Text('Messages'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: User',
      style: optionStyle,
    ),
    Text(
      'Index 2: Food',
      style: optionStyle,
    ),
    Text(
      'Index 3: Settings',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _showSnackBar();
    });
  }

  void _showSnackBar() {
    String message = '';
    switch (_selectedIndex) {
      case 0:
        message = 'You tapped Home';
        break;
      case 1:
        message = 'You tapped User';
        break;
      case 2:
        message = 'You tapped Food';
        break;
      case 3:
        message = 'You tapped Settings';
        break;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void showScanner(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return MobileScanner(
          controller: MobileScannerController(
            facing: CameraFacing.back,
            torchEnabled: true,
          ),
          onDetect: (capture) {
            final List<Barcode> barcodes = capture.barcodes;
            //final Uint8List? image = capture.image;
            for (final barcode in barcodes) {
              debugPrint('Barcode found! ${barcode.rawValue}');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Barcode found: ${barcode.rawValue}'),
                ),
              );
            }
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarExample(),
      body: const Center(
        child: MyStatelessWidget(),
      ),
      drawer: const DrawerExample(), //TI SKATAAAAAAAAAAAAAAAAAAAAA

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showScanner(context);
        },
        backgroundColor: Colors.yellow,
        child: const Icon(Icons.add),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color.fromRGBO(218, 247, 166, 100),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.accessibility_new_outlined),
            label: 'User',
            backgroundColor: Color.fromRGBO(255, 165, 0, 100),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            label: 'Food',
            backgroundColor: Color.fromRGBO(255, 87, 51, 100),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Color.fromRGBO(199, 0, 57, 100),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
