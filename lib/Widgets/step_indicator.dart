import 'package:flutter/material.dart';
import '../theme.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;
  const StepIndicator({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    final steps = ['Personal\nInfo', 'Plot\nDetails', 'Account\nSetup'];
    return Row(
      children: List.generate(steps.length, (i) {
        final stepNum = i + 1;
        final isDone = stepNum < currentStep;
        final isActive = stepNum == currentStep;

        return Expanded(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: isDone
                            ? AppTheme.primary
                            : isActive
                            ? AppTheme.primary
                            : AppTheme.divider,
                        shape: BoxShape.circle,
                        boxShadow: isActive
                            ? [
                          BoxShadow(
                            color: AppTheme.primary.withOpacity(0.3),
                            blurRadius: 8,
                            spreadRadius: 1,
                          )
                        ]
                            : [],
                      ),
                      child: Center(
                        child: isDone
                            ? const Icon(Icons.check,
                            color: Colors.white, size: 16)
                            : Text(
                          '$stepNum',
                          style: TextStyle(
                            color: isActive
                                ? Colors.white
                                : AppTheme.textSecondary,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      steps[i],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        color: isActive || isDone
                            ? AppTheme.primary
                            : AppTheme.textSecondary,
                        fontWeight: isActive
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              if (i < steps.length - 1)
                Expanded(
                  child: Container(
                    height: 2,
                    margin: const EdgeInsets.only(bottom: 24),
                    decoration: BoxDecoration(
                      color: isDone ? AppTheme.primary : AppTheme.divider,
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}