import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providers/provider/driving_page_provider.dart';

class DrivingPage extends StatelessWidget {
  const DrivingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController ageController = TextEditingController();
    return ChangeNotifierProvider<DrivingPageProvider>(
      create: (context) => DrivingPageProvider(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.blueGrey,
            appBar: AppBar(
              backgroundColor: Colors.amber.withOpacity(.9),
              toolbarHeight: 120,
              title: Center(
                child: Text(
                  'Driving Eligibility',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
            ),
            body: Consumer<DrivingPageProvider>(
              builder: (context, provider, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: provider.isEligible
                              ? Colors.green
                              : Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextField(
                        keyboardType: ,
                        controller: ageController,
                        decoration: InputDecoration(
                          hintText: 'Enter your age',
                          hintStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                          labelText: 'Your Age',
                          labelStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.all(.circular(20)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.all(.circular(20)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        minimumSize: Size(120, 50),
                        padding: EdgeInsets.all(20),
                        shadowColor: Colors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(.circular(20)),
                        ),
                        elevation: 3,
                        side: BorderSide(color: Colors.white, width: 1.5),
                      ),
                      onPressed: () {
                        final int age = int.parse(ageController.text.trim());
                        provider.checkEligible(age);
                      },
                      child: Text('Check'),
                    ),
                    SizedBox(height: 20),
                    Text(provider.message),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
