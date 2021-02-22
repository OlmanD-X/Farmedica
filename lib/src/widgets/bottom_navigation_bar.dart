import 'package:flutter/material.dart';

class NavigationBarBottom extends StatelessWidget {
  final Function f;
  final int position;

  NavigationBarBottom({@required this.f, @required this.position});

  @override
  Widget build(BuildContext context) {
    bool isSelected0 = false;
    bool isSelected1 = false;
    bool isSelected3 = false;
    bool isSelected4 = false;
    switch (position) {
      case 0:
        isSelected0 = true;
        break;
      case 1:
        isSelected1 = true;
        break;
      case 2:
        isSelected3 = true;
        break;
      case 3:
        isSelected4 = true;
        break;
    }
    return Container(
      color: Colors.grey[100],
      height: 70.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              IconButton(
                icon: Icon(Icons.apartment),
                onPressed: f(0),
                color: isSelected0 ? Colors.blue : Colors.grey,
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(bottom: 3.0),
              ),
              Text(
                'Citas',
                style: TextStyle(
                  color: isSelected0 ? Colors.blue : Colors.grey,
                  fontSize: 11.0,
                ),
              ),
            ],
          ),
          Column(
            children: [
              IconButton(
                icon: Icon(Icons.receipt),
                onPressed: f(1),
                color: isSelected1 ? Colors.blue : Colors.grey,
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(bottom: 3.0),
              ),
              Text(
                'Examenes',
                style: TextStyle(
                  color: isSelected1 ? Colors.blue : Colors.grey,
                  fontSize: 11.0,
                ),
              ),
            ],
          ),
          IconButton(
            icon: Icon(
              Icons.add_circle_outline,
            ),
            iconSize: 50.0,
            onPressed: f(-1),
            color: Colors.grey,
          ),
          Column(
            children: [
              IconButton(
                icon: Icon(Icons.favorite),
                onPressed: f(2),
                color: isSelected3 ? Colors.blue : Colors.grey,
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(bottom: 3.0),
              ),
              Text(
                'Recetas',
                style: TextStyle(
                  color: isSelected3 ? Colors.blue : Colors.grey,
                  fontSize: 11.0,
                ),
              ),
            ],
          ),
          Column(
            children: [
              IconButton(
                icon: Icon(Icons.info),
                onPressed: f(3),
                color: isSelected4 ? Colors.blue : Colors.grey,
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(bottom: 3.0),
              ),
              Text(
                'Información',
                style: TextStyle(
                  color: isSelected4 ? Colors.blue : Colors.grey,
                  fontSize: 11.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
