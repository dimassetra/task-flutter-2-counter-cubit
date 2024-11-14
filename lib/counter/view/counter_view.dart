import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_2_cubit/counter/counter.dart';

/// {@template counter_view}
/// A [StatelessWidget] which reacts to the provided
/// [CounterCubit] state and notifies it in response to user input.
/// {@endtemplate}
class CounterView extends StatelessWidget {
  /// {@macro counter_view}
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CounterCubit, CounterState>(
      listener: (context, state) {
        if (state.isMultipleOfFive) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'You got ${state.count}!',
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.deepPurple,
              duration: const Duration(seconds: 1),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Enhanced Counter App'),
            backgroundColor: state.isMultipleOfFive ? Colors.purple : null,
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: state.isMultipleOfFive
                  ? const LinearGradient(
                      colors: [Colors.deepPurple, Colors.indigo],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Current Count:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: state.isMultipleOfFive
                          ? Colors.purpleAccent
                          : Colors.cyan.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: state.isMultipleOfFive
                          ? [
                              BoxShadow(
                                color: Colors.purple.withOpacity(0.5),
                                blurRadius: 10,
                                spreadRadius: 5,
                              )
                            ]
                          : null,
                    ),
                    child: Text(
                      '${state.count}',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: state.isMultipleOfFive
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Basic operation buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton(
                        onPressed: () =>
                            context.read<CounterCubit>().decrement(),
                        backgroundColor: Colors.red,
                        child: const Icon(Icons.remove),
                      ),
                      const SizedBox(width: 20),
                      FloatingActionButton(
                        onPressed: () =>
                            context.read<CounterCubit>().increment(),
                        backgroundColor: Colors.green,
                        child: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Additional operation buttons
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    alignment: WrapAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () =>
                            context.read<CounterCubit>().decrementByTwo(),
                        icon: const Icon(Icons.exposure_minus_2),
                        label: const Text('Decrease by 2'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () =>
                            context.read<CounterCubit>().multiplyByTwo(),
                        icon: const Icon(Icons.close),
                        label: const Text('Multiply by 2'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => context.read<CounterCubit>().reset(),
                        icon: const Icon(Icons.refresh),
                        label: const Text('Reset'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
