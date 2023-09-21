import 'package:flutter/material.dart';
import 'package:safe_go_dart/select_destination_buttons.dart';

class SelectDestination extends StatelessWidget {

  const SelectDestination({super.key,});

  @override
  Widget build(BuildContext context) {
    double height = 14.0;
    return Column(
      children: [
        SizedBox(height: height),
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
                decoration: BoxDecoration(
                  color:  const Color.fromRGBO(216,244,228,1), // Color de fondo del icono
                  borderRadius: BorderRadius.circular(25.0), // Bordes redondeados
                ),
                child: IconButton(
                  icon: const Icon(Icons.calendar_month,color: Color.fromRGBO(64,78,72,1),size: 50),
                  onPressed: () {
                  },
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: height),
        Row(
          children: [

            DirectionButton(
              onPressed: () {
                // Acción al presionar el botón
              },
              icon: Icons.home_outlined,
              label: 'Home',
            ),

          ],
        ),
        SizedBox(height: height),
        Row(
          children: [

            DirectionButton(
              onPressed: () {
                // Acción al presionar el botón
              },
              icon: Icons.work_outline,
              label: 'Work',
            ),

          ],
        ),
        SizedBox(height: height),
        Row(
          children: [

            DirectionButton(
              onPressed: () {
                // Acción al presionar el botón
              },
              icon: Icons.school_outlined,
              label: 'School',
            ),

          ],
        ),
        SizedBox(height: height),
        Row(
          children: [
            DirectionButton(
              onPressed: () {
                // Acción al presionar el botón
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
