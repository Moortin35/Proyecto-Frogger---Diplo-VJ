# Proyecto Frogger

Primer proyecto entregable de la Diplomatura en Desarrollo de Videojuegos de la UNQ, correspondiente a las materias de Introducción a los Videojuegos y Elementos Básicos de Programación de Videojuegos.

**Alumno**: Martín Nicolás Delgado

**Docente**: Tobias Quimey Moscatelli

## Presentación

El proyecto se hizo siguiendo la guía proporcionada por la cátedra y siguiendo los videos de las clases grabadas, se hicieron cambios leves en comparación con el original en cuanto a código, la implementación de los assets fueron realizados con la herramienta piskel.

## Temática

La idea de la temática nació basándose en mi ciudad natal y su invierno cargado de bastante nieve. 
La protagonista es Valentina, ella volvió en vacaciones de invierno a su casa y a la par sus sobrinos están de visitas. A Valen le gustan los gatos calicos y tiene varios en su casa. 
Una tarde los sobrinos de Valen se pusieron a jugar a la guerra de bolas de nieve en su patio, sus gatos se escaparon y Valen quiere volver a entrarlos a la casa.

## Cambios

Algunos cambios se realizaron en comparación a la implementación original, si bien algunos son mínimos, los voy a mencionar a continuación:

* Se cambió la orientación del tablero de vertical a horizontal, siendo también que los proyectiles obstáculo ahora también se emiten de manera horizontal
* Los proyectiles no salen únicamente de un lado(izquierda hacia derecha), sino que también se disparan del lado derecho de la pantalla hacia la izquierda.
* Los bordes hasta donde puede moverse el jugador fue limitado en el alto de pantalla(eje y), para dejar un marco de 16 píxeles para la interfaz de vidas.
* Tile set nuevo con temática de nieve.
* En vez de ser casas que se visitan y se llenan con un objeto, aquí tomaremos el gato("casa") y este desaparecerá dando por entender que se obtuvo o se completó la obtención del mismo, mostrando los faltantes en el mapa.
* Un poquito de libertad creativa a la hora de representar el mapa, en vez de representar caminos, busqué que se asemeje al patio de una casa.
* Se agrego música simple y en loop con temática invernal. Y un efecto de sonido de obtención del gato.
* Se agrego un breve texto al lado de los muñecos de nieve que diga: "Vidas restantes".
* Puede que haya algún que otro cambio que me esté pasando por alto, si me acuerdo aparecerá, _sepa disculpar. (?_

## Creditos Adicionales

* Música: [Windchill](https://opengameart.org/content/windchill) de [genderfreak](https://genderfreak.itch.io/)

* Fuentes de Texto: [Pixelify Sans](https://fonts.google.com/share?selection.family=Pixelify+Sans:wght@400..700) de [Google Fonts](https://fonts.google.com/)

* Efecto de Sonido: [Player Hit](https://opengameart.org/content/player-hit-damage) de GreyFrogGames

## Futuras Ideas

Algunas ideas quedaron en el camino y no tuve tiempo a implementarlas a la hora de la entrega debido a que estoy un poco ajustado de tiempo y con parciales. 

* Spawn aleatorio de los gatos, en un principio aparecería uno solo en algún punto aleatorio del mapa
* Asset de marco para los bordes de mapa.
* Menú previo a jugar y contando brevemente "la historia o premisa"
* Comentar bien el código y corregir los nombres de algunas variables si llego a encontrar que haga falta.
* Implementar un objeto muñeco de nieve que al tomarlo se agregue una vida extra, también con spawn aleatorio.
