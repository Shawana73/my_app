import 'package:flutter/material.dart';
import 'registration_screen3.dart';

class RegistrationStep2 extends StatefulWidget {
  const RegistrationStep2({super.key});

  @override
  State<RegistrationStep2> createState() => _RegistrationStep2State();
}

class _RegistrationStep2State extends State<RegistrationStep2> {

  int selectedPlot = 0;

  static const Color primaryBlue = Color(0xFF5289AD);
  static const Color darkBlue = Color(0xFF243C4C);
  static const Color lightBlue = Color(0xFF698696);
  static const Color backgroundColor = Color(0xFFF4FCFB);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [

              const SizedBox(height: 15),

              const Text(
                "Apply for Plot Balloting",
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.visible,
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: darkBlue,
                  fontFamily: 'Poppins',
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Complete your registration in 3 simple steps",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: lightBlue,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 30),

              // Progress Bar
              Row(
                children: [

                  Expanded(
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: primaryBlue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  Expanded(
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: primaryBlue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  Expanded(
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Step 2 of 3",
                  style: TextStyle(
                    color: lightBlue,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),

              const SizedBox(height: 25),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 15,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "Plot Details",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: darkBlue,
                        fontFamily: 'Poppins',
                      ),
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      "Select your desired plot category",
                      style: TextStyle(
                        color: lightBlue,
                        fontFamily: 'Poppins',
                      ),
                    ),

                    const SizedBox(height: 25),

                    const Text(
                      "Plot Category",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: darkBlue,
                        fontFamily: 'Poppins',
                      ),
                    ),

                    const SizedBox(height: 15),

                    plotCard(
                      "5 Marla",
                      "PKR 25 Lakh",
                      0,
                    ),

                    const SizedBox(height: 12),

                    plotCard(
                      "10 Marla",
                      "PKR 45 Lakh",
                      1,
                    ),

                    const SizedBox(height: 12),

                    plotCard(
                      "1 Kanal",
                      "PKR 85 Lakh",
                      2,
                    ),

                    const SizedBox(height: 25),

                    const Text(
                      "Required Documents",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: darkBlue,
                        fontFamily: 'Poppins',
                      ),
                    ),

                    const SizedBox(height: 12),

                    Container(
                      padding: const EdgeInsets.all(16),

                      decoration: BoxDecoration(
                        color: const Color(0xFFEAF4FB),
                        borderRadius: BorderRadius.circular(14),
                      ),

                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text("• CNIC Front Copy"),
                          SizedBox(height: 5),

                          Text("• CNIC Back Copy"),
                          SizedBox(height: 5),

                          Text("• Passport Size Photograph"),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    const Text(
                      "Upload CNIC",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: darkBlue,
                        fontFamily: 'Poppins',
                      ),
                    ),

                    const SizedBox(height: 12),





                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("File Upload Coming Soon"),
                          ),
                        );
                      },

                      child: Container(
                        height: 140,

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),

                          border: Border.all(
                            color: const Color(0xFFE3EAF0),
                          ),
                        ),

                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Icon(
                                Icons.upload_file,
                                size: 40,
                                color: lightBlue,
                              ),

                              SizedBox(height: 10),

                              Text(
                                "Tap to Upload File",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: darkBlue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    Row(
                      children: [

                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },

                            style: OutlinedButton.styleFrom(
                              minimumSize:
                              const Size(double.infinity, 55),
                            ),

                            child: const Text(
                              "Back",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                  const RegistrationScreen3(),
                                ),
                              );
                            },

                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryBlue,
                              minimumSize:
                              const Size(double.infinity, 55),

                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(12),
                              ),
                            ),

                            child: const Text(
                              "Continue",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget plotCard(
      String title,
      String price,
      int index,
      ) {
    bool selected = selectedPlot == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPlot = index;
        });
      },

      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),

          border: Border.all(
            color: selected
                ? primaryBlue
                : const Color(0xFFE3EAF0),
            width: 1.5,
          ),
        ),

        child: Row(
          children: [

            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              color: primaryBlue,
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    price,
                    style: const TextStyle(
                      color: lightBlue,
                      fontSize: 13,
                    ),
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