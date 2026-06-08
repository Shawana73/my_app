import 'package:flutter/material.dart';

class RegistrationScreen3 extends StatefulWidget {
  const RegistrationScreen3({super.key});

  @override
  State<RegistrationScreen3> createState() =>
      _RegistrationScreen3State();
}

class _RegistrationScreen3State
    extends State<RegistrationScreen3> {

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

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
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
              ),

              const SizedBox(height: 30),

              // Progress
              Row(
                children: [

                  Expanded(
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: primaryBlue,
                        borderRadius:
                        BorderRadius.circular(20),
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  Expanded(
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: primaryBlue,
                        borderRadius:
                        BorderRadius.circular(20),
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  Expanded(
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: primaryBlue,
                        borderRadius:
                        BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Step 3 of 3",
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
                      color: Colors.black12,
                      blurRadius: 15,
                    ),
                  ],
                ),

                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "Account Setup",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: darkBlue,
                        fontFamily: 'Poppins',
                      ),
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      "Create your account credentials",
                      style: TextStyle(
                        color: lightBlue,
                        fontFamily: 'Poppins',
                      ),
                    ),

                    const SizedBox(height: 25),

                    buildField(
                      "Username",
                      "Enter username",
                    ),

                    const SizedBox(height: 18),

                    buildPasswordField(),

                    const SizedBox(height: 18),

                    buildConfirmPasswordField(),

                    const SizedBox(height: 30),

                    Row(
                      children: [

                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },

                            child: const Text(
                              "Back",
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {

                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text(
                                      "Success",
                                    ),
                                    content: const Text(
                                      "Registration Completed Successfully",
                                    ),
                                    actions: [

                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(
                                              context);
                                        },
                                        child:
                                        const Text("OK"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },

                            style:
                            ElevatedButton.styleFrom(
                              backgroundColor:
                              primaryBlue,
                            ),

                            child: const Text(
                              "Complete Registration",
                              style: TextStyle(
                                color: Colors.white,
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

  Widget buildField(
      String label,
      String hint,
      ) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [

        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: darkBlue,
          ),
        ),

        const SizedBox(height: 8),

        TextField(
          decoration: InputDecoration(
            hintText: hint,

            filled: true,
            fillColor: Colors.white,

            border: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPasswordField() {
    return TextField(
      obscureText: obscurePassword,

      decoration: InputDecoration(
        hintText: "Enter password",

        suffixIcon: IconButton(
          icon: Icon(
            obscurePassword
                ? Icons.visibility_off
                : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              obscurePassword =
              !obscurePassword;
            });
          },
        ),

        border: OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget buildConfirmPasswordField() {
    return TextField(
      obscureText: obscureConfirmPassword,

      decoration: InputDecoration(
        hintText: "Confirm password",

        suffixIcon: IconButton(
          icon: Icon(
            obscureConfirmPassword
                ? Icons.visibility_off
                : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              obscureConfirmPassword =
              !obscureConfirmPassword;
            });
          },
        ),

        border: OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(12),
        ),
      ),
    );
  }
}