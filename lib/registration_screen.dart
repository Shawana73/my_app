import 'package:flutter/material.dart';
import 'registration_step2.dart';
class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  // Arctic Reflection Theme
  static const Color primaryBlue = Color(0xFF5289AD);
  static const Color darkBlue = Color(0xFF243C4C);
  static const Color lightBlue = Color(0xFF698696);
  static const Color backgroundColor = Color(0xFFF4FCFB);
  static const Color borderColor = Color(0xFFE3EAF0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Back Button
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: darkBlue,
                  ),
                ),

                const SizedBox(height: 10),

                // Title
                Center(
                  child: Column(
                    children: const [

                      Text(
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

                      SizedBox(height: 8),

                      Text(
                        "Complete your registration in 3 simple steps",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: lightBlue,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Progress Indicator
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
                          color: Colors.grey.shade300,
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
                    "Step 1 of 3",
                    style: TextStyle(
                      color: lightBlue,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // Card
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
                        "Personal Information",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: darkBlue,
                          fontFamily: 'Poppins',
                        ),
                      ),

                      const SizedBox(height: 6),

                      const Text(
                        "Please provide your personal details",
                        style: TextStyle(
                          color: lightBlue,
                          fontFamily: 'Poppins',
                        ),
                      ),

                      const SizedBox(height: 25),

                      buildField(
                        "Full Name",
                        "Enter your full name",
                      ),

                      const SizedBox(height: 16),

                      buildField(
                        "CNIC Number",
                        "35201-1234567-8",
                      ),

                      const SizedBox(height: 16),

                      buildField(
                        "Phone Number",
                        "+92 300 1234567",
                      ),

                      const SizedBox(height: 16),

                      buildField(
                        "Email Address",
                        "example@gmail.com",
                      ),

                      const SizedBox(height: 16),

                      const Text(
                        "Address",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: darkBlue,
                          fontFamily: 'Poppins',
                        ),
                      ),

                      const SizedBox(height: 8),

                      TextField(
                        maxLines: 3,

                        decoration: InputDecoration(
                          hintText: "Enter your address",

                          hintStyle: const TextStyle(
                            color: Color(0xFFACBCBF),
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins',
                          ),

                          filled: true,
                          fillColor: Colors.white,

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFFE3EAF0),
                            ),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: primaryBlue,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        height: 55,

                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegistrationStep2(),
                              ),
                            );
                          },

                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryBlue,

                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(12),
                            ),
                          ),

                          child: const Text(
                            "Continue",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
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
    );
  }

  Widget buildField(
      String label,
      String hint,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: darkBlue,
            fontFamily: 'Poppins',
          ),
        ),

        const SizedBox(height: 8),

        TextField(
          decoration: InputDecoration(
            hintText: hint,

            hintStyle: const TextStyle(
              color: Color(0xFFACBCBF),
              fontSize: 15,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins',
            ),

            filled: true,
            fillColor: Colors.white,

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFE3EAF0),
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: primaryBlue,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}