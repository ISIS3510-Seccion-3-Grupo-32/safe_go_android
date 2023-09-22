import 'package:flutter/material.dart';

class StartRide extends StatelessWidget {

  const StartRide({super.key,});

  @override
  Widget build(BuildContext context) {
    double espaciado = 30.0;
    double alineacion = 100.0;
    return Row(children: [
      Padding(
        padding: const EdgeInsets.only(right: 0),
        child: Column(
          children: [
            const Row(
              children:[
                Padding(
                  padding: EdgeInsets.only(right: 0),
                  child: Text('Your safe route is set!',
                    style:TextStyle(
                      fontSize: 22.9, // Tamaño de fuente
                      fontWeight: FontWeight.bold, // Peso de la fuente (opcional)
                      color: Colors.black, // Color del texto (opcional)
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: espaciado),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children:[
                Container(
                  padding:  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                    color:  const Color.fromRGBO(216,244,228,1), // Color de fondo del icono
                    borderRadius: BorderRadius.circular(60.0), // Bordes redondeados
                  ),
                  child: const Icon(Icons.access_time,color: Color.fromRGBO(64,78,72,1),size: 20),

                ),
                Padding(
                  padding: EdgeInsets.only(left:18.0, right: alineacion- 7),
                  child: const Text('9:00 a.m',
                    style:TextStyle(
                      fontSize: 20, // Tamaño de fuente
                      fontWeight: FontWeight.normal, // Peso de la fuente (opcional)
                      color: Colors.black, // Color del texto (opcional)
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: espaciado -4,),
            Row(children: [
              Padding(
                padding: EdgeInsets.only(left:0.0, right: alineacion + 20),
                child: const Text('Trip details:',style:TextStyle(
                  fontSize: 20, // Tamaño de fuente
                  fontWeight: FontWeight.normal, // Peso de la fuente (opcional)
                  color: Colors.black, // Color del texto (opcional)
                ),
                ),
              ),
            ],),
            SizedBox(height: espaciado),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children:[
                Container(
                  padding:  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                    color:  const Color.fromRGBO(216,244,228,1), // Color de fondo del icono
                    borderRadius: BorderRadius.circular(60.0), // Bordes redondeados
                  ),
                  child: const Icon(Icons.place_outlined,color: Color.fromRGBO(64,78,72,1),size: 20),

                ),
                Padding(
                  padding: EdgeInsets.only(left:0, right:alineacion - 80),
                  child: const Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left:0, right: 0),
                        child: Text('From: Cl 18# 1 -86',
                          style:TextStyle(
                            fontSize: 15, // Tamaño de fuente
                            fontWeight: FontWeight.normal, // Peso de la fuente (opcional)
                            color: Colors.black, // Color del texto (opcional)
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left:20.0, right: 0),
                        child: Text('To:      Cr 40 # 68 - 50',
                          style:TextStyle(
                            fontSize: 15, // Tamaño de fuente
                            fontWeight: FontWeight.normal, // Peso de la fuente (opcional)
                            color: Colors.black, // Color del texto (opcional)
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: espaciado -4),
             Row(children: [
              Padding(
                padding: EdgeInsets.only(left:0.0, right: alineacion -20),
                child: const Text('Estimated time:',style:TextStyle(
                  fontSize: 20, // Tamaño de fuente
                  fontWeight: FontWeight.normal, // Peso de la fuente (opcional)
                  color: Colors.black, // Color del texto (opcional)
                ),
                ),
              ),
            ],),
            SizedBox(height: espaciado -4),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children:[
                Container(
                  padding:  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                    color:  const Color.fromRGBO(216,244,228,1), // Color de fondo del icono
                    borderRadius: BorderRadius.circular(60.0), // Bordes redondeados
                  ),
                  child: const Icon(Icons.timer_sharp,color: Color.fromRGBO(64,78,72,1),size: 20),

                ),
                Padding(
                  padding: EdgeInsets.only(left:18, right: alineacion - 29 ),
                  child: const Text('36 minutes',
                    style:TextStyle(
                      fontSize: 20, // Tamaño de fuente
                      fontWeight: FontWeight.normal, // Peso de la fuente (opcional)
                      color: Colors.black, // Color del texto (opcional)
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: espaciado +18)
          ],
        ),
      ),
       Padding(
         padding: const EdgeInsets.only(left: 19),
         child: Column(children: [
          Container(
            padding:  const EdgeInsets.only(bottom: 35, right: 35),
            decoration: BoxDecoration(
              color:  const Color.fromRGBO(216,244,228,1), // Color de fondo del icono
              borderRadius: BorderRadius.circular(8.0), // Bordes redondeados
            ),
            child: IconButton(
               icon: const Icon(Icons.navigation,color: Color.fromRGBO(64,78,72,1),
                size: 64),
              onPressed: () {},
            ),

          ),
      ],
      ),
       ),
    ],
    );
  }
}
