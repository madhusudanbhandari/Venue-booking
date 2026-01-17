import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/about.dart';
import 'package:flutter_application_1/features/contact.dart';
import 'package:flutter_application_1/features/faq.dart';
import 'package:flutter_application_1/features/home.dart';
import 'package:flutter_application_1/features/learn_more.dart';
import 'package:flutter_application_1/features/services.dart';
import 'login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF061A3A),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 30),
        child: Column(
          children: [
            /// 🔹 TOP NAV BAR
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Book-Garau",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const Home()),
                        );
                      },
                      child: const Text("Home"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ServicesPage(),
                          ),
                        );
                      },
                      child: const Text("Services"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const AboutPage()),
                        );
                      },
                      child: const Text("About"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ContactPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "Contact",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const FaqPage()),
                        );
                      },
                      child: const Text("FAQ"),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          241,
                          207,
                          219,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginPage()),
                        );
                      },
                      child: const Text("SIGN UP"),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 80),

            /// 🔹 MAIN CONTENT
            Expanded(
              child: Row(
                children: [
                  /// LEFT TEXT
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Venue",
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "BOOKING",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 46,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Book venues easily for meetings, events and social gatherings with secure payments and verified owners.",
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 30),

                        /// BUTTONS
                        Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  236,
                                  196,
                                  209,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const LoginPage(),
                                  ),
                                );
                              },
                              child: const Text("LOGIN"),
                            ),
                            const SizedBox(width: 20),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.white),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const LearnMore(),
                                  ),
                                );
                              },
                              child: const Text(
                                "LEARN MORE",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  /// RIGHT IMAGE
                  Expanded(
                    child: Image.asset('assets/venue.png', fit: BoxFit.contain),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(title, style: const TextStyle(color: Colors.white70)),
    );
  }
}
