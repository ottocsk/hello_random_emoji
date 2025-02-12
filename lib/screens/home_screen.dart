// This file is part of Hello Random Emoji
// https://github.com/eduhoratiu/hello_random_emoji
//
// Copyright 2025 eduhoratiu. All rights reserved.
// Licensed under the MIT license. See LICENSE file in the project root for details.

import 'dart:math';

import 'package:flutter/material.dart';

import '../data/emojis.dart';
import '../models/emoji.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  /// The random number generator used to select a random emoji.
  final Random _random = Random();

  /// The emoji that is currently displayed.
  late Emoji _currentEmoji;

  /// Animation controller for the emoji.
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller.
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Randomize the emoji when the screen is first displayed.
    _randomizeEmoji();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Randomizes the emoji that is currently displayed.
  void _randomizeEmoji() {
    final int index = _random.nextInt(emojiList.length);
    setState(() {
      _currentEmoji = emojiList[index];
    });
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Emoji Generator'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Text(
                  'This app will randomly generate any emoji. Challenge your friends and see if they guess it by asking a maximum of 5 yes/no questions.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ScaleTransition(
                scale: CurvedAnimation(
                  parent: _controller,
                  curve: Curves.elasticOut,
                ),
                child: Text(
                  _currentEmoji.emoji,
                  style: const TextStyle(fontSize: 128),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                _currentEmoji.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _randomizeEmoji,
        tooltip: 'Randomize Emoji',
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.shuffle),
      ),
    );
  }
}