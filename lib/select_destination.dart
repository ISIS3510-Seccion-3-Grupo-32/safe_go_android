import 'package:flutter/material.dart';
import 'package:safe_go_dart/select_destination_buttons.dart';

class SelectDestination extends StatelessWidget {
  final Function(int) trigger;
  const SelectDestination({super.key, required  this.trigger});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final spacingHeight = screenHeight * 0.02;
    return Column(
      children: [
        SizedBox(height: spacingHeight),
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: SizedBox(
                width: 245,
                child: TextField(
                  decoration: InputDecoration(
                    filled: true, // Activa el relleno de fond
                    prefixIcon: Icon(Icons.search),
                    fillColor: Color.fromRGBO(248, 252, 252, 1),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(style: BorderStyle.none, strokeAlign: BorderSide.strokeAlignInside, width: 0, color: Color(1))),
                    hintText: 'Where to?',
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left:0.0),
              child: Container(
                padding: const EdgeInsets.only(right: 15, bottom: 15),
                decoration: BoxDecoration(
                  color:  const Color.fromRGBO(216,244,228,1), // Color de fondo del icono
                  borderRadius: BorderRadius.circular(50.0), // Bordes redondeados
                ),
                child: IconButton(
                  icon: const Icon(Icons.calendar_month,color: Color.fromRGBO(64,78,72,1),size: 45),
                  onPressed: () {
                  },
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: spacingHeight),
        Row(
          children: [

            DirectionButton(
              onPressed: () {
                trigger(1);
              },
              icon: Icons.home_outlined,
              label: 'Home',
            ),

          ],
        ),
        SizedBox(height: spacingHeight),
        Row(
          children: [

            DirectionButton(
              onPressed: () {
                trigger(1);
              },
              icon: Icons.work_outline,
              label: 'Work',
            ),
          ],
        ),
        SizedBox(height: spacingHeight),
        Row(
          children: [

            DirectionButton(
              onPressed: () {
                trigger(1);
              },
              icon: Icons.school_outlined,
              label: 'School',
            ),

          ],
        ),
        SizedBox(height: spacingHeight),
        Row(
          children: [

            DirectionButton(
              onPressed: () {
                trigger(1);
              },
              icon: Icons.favorite_outline,
              label: 'Partner',
            ),
          ],
        ),
      ],
    );
  }
}
