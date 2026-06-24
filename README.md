<div align="center">

<img width="100%" alt="RickVerse — portada Rick and Morty" src="assets/images/rick-y-morty_portada2.jpg" />

<h1>RickVerse</h1>

<p><strong>RickVerse — Aplicación móvil dedicada a la serie Rick and Morty.</strong></p>

<p>
<img src="https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white" alt="Flutter 3.x">
<img src="https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart&logoColor=white" alt="Dart 3.x">
<img src="https://img.shields.io/badge/License-MIT-blue.svg" alt="License: MIT">
<img src="https://img.shields.io/badge/platform-Android%20%7C%20Web%20%7C%20Windows-lightgrey" alt="Platform">
</p>

<p>
<a href="https://skillicons.dev"><img src="https://skillicons.dev/icons?i=flutter,dart,windows,vscode,git,github&theme=dark&perline=8" alt="Stack principal" /></a>
</p>

</div>

Aplicación móvil dedicada a la serie **Rick and Morty**, desarrollada con **Flutter** como proyecto académico de la materia **Introducción al Desarrollo de Aplicaciones Móviles**.

---

## Información académica

| Campo | Detalle |
|-------|--------|
| **Materia** | Introducción al Desarrollo de Aplicaciones Móviles |
| **Profesor** | Amadis Suárez Genao |
| **Alumno** | Christian Gil |
| **Matrícula** | 2012-1036 |

---

## Descripción del proyecto

Desarrollen una aplicación móvil dedicada a una serie, película o canal de YouTube. Asegúrense de que su aplicación incluya las siguientes vistas:

### Portada

La pantalla de inicio incluye un **carrusel (slider)** con imágenes de la serie, el logo de RickVerse superpuesto y un menú de acceso rápido a las demás secciones de la app.


### Personajes

Se consultan personajes desde la **Rick and Morty API**. La lista muestra al menos tres personajes con nombre, estado y especie. Al seleccionar uno se abre la vista de detalle con foto, estado, especie, tipo, género, origen, ubicación y cantidad de episodios.

### Momentos

Tres momentos favoritos con imagen y título. En el detalle se muestra la descripción completa y un **reproductor de YouTube integrado** (`youtube_player_iframe`) que reproduce el video dentro de la app.

### Acerca de

Vista con imagen de portada, descripción de la serie, tipo de obra, **creadores** (Justin Roiland y Dan Harmon), **cantidad de temporadas**, año de estreno y tema principal.

### Juega Conmigo

Mini-juego de **adivinanza de personajes** (estilo ahorcado). Se muestra la imagen de un personaje aleatorio de la API, pistas de especie/género e intentos limitados. Incluye teclado de letras, marcador de aciertos/fallos y racha.

Referencia de ejemplo: [adamix.net/tareas/itla2](https://adamix.net/tareas/itla2/)

### Contrátame

Tarjeta de perfil con **foto**, nombre, matrícula y enlaces de contacto (correo, teléfono, GitHub y LinkedIn).

---

## Capturas de pantalla

Capturas tomadas desde la app en dispositivo móvil.

| Portada | Personajes |
|:------:|:---------:|
| ![Portada](docs/screenshots/homePage.jpg) | ![Personajes](docs/screenshots/personajes.jpg) |
| *Pantalla de inicio con carrusel* | *Listado de personajes* |

| Detalle personaje | Momentos |
|:----------------:|:--------:|
| ![Detalle personaje](docs/screenshots/rickSanchez_personaje.jpg) | ![Momentos](docs/screenshots/momentos.jpg) |
| *Foto y datos del personaje* | *Momentos favoritos* |

| Detalle momento | Juega conmigo |
|:--------------:|:-------------:|
| ![Detalle momento](docs/screenshots/pickleRick.jpg) | ![Juego](docs/screenshots/juego1.jpg) |
| *Detalle con video integrado* | *Mini-juego de adivinanza* |

| Acerca de | Contrátame |
|:--------:|:---------:|
| ![Acerca de](docs/screenshots/acercaDe.jpg) | ![Contrátame](docs/screenshots/contratame.jpg) |
| *Información de la serie* | *Datos de contacto y foto* |

| Juego — intentos | Juego — resultado |
|:---------------:|:----------------:|
| ![Juego intentos](docs/screenshots/juego2.jpg) | ![Juego resultado](docs/screenshots/juego3.jpg) |
| *Partida en curso* | *Fin de ronda* |

---

## Funcionalidades principales

- Navegación inferior con **MainShell** (Inicio, Juega conmigo, Acerca de, Perfil).
- Navigator anidado en la pestaña Inicio para mantener la barra al navegar a Personajes y Momentos.
- Diseño **responsive** para móvil, tablet y web (`Responsive`, `ResponsiveContent`).
- Tema oscuro con paleta inspirada en Rick and Morty.
- Consumo de datos desde la [Rick and Morty API](https://rickandmortyapi.com/).

---

## Estructura del proyecto

```text
lib/
├── core/
│   ├── constants/       # Colores, assets, API, YouTube
│   ├── routes/          # Rutas nombradas
│   ├── theme/           # Tema Material 3
│   ├── utils/           # Utilidades responsive
│   └── widgets/         # Reproductor YouTube, mensajes de error
├── data/
│   ├── models/          # CharacterModel, MomentModel
│   └── services/        # RickAndMortyService
├── features/
│   ├── about/           # Acerca de
│   ├── characters/      # Personajes y detalle
│   ├── game/            # Juega conmigo
│   ├── hire_me/         # Contrátame
│   ├── home/            # Portada y MainShell
│   └── moments/         # Momentos y detalle
├── app.dart
└── main.dart

assets/images/           # Imágenes locales (logo, momentos, perfil)
docs/screenshots/        # Capturas de pantalla para el README
```

---

## Requisitos previos

<p align="center">
  <a href="https://flutter.dev" title="Flutter"><img src="https://skillicons.dev/icons?i=flutter" alt="Flutter" /></a>
  <a href="https://dart.dev" title="Dart"><img src="https://skillicons.dev/icons?i=dart" alt="Dart" /></a>
  <a href="https://git-scm.com" title="Git"><img src="https://skillicons.dev/icons?i=git" alt="Git" /></a>
</p>

| Requisito | Descripción |
|-----------|-------------|
| **Flutter SDK** | Versión 3.x — [Instalación](https://docs.flutter.dev/get-started/install) |
| **Dart** | 3.x con null safety |
| **Plataforma** | Emulador/dispositivo Android, navegador Chrome o escritorio Windows |
| **Red** | Conexión a internet para la Rick and Morty API y videos de YouTube |

---

## Instrucciones de uso

### 1. Instalar dependencias

```bash
flutter pub get
```

### 2. Ejecutar la aplicación

```bash
# Dispositivo/emulador conectado o Chrome
flutter run

# Web
flutter run -d chrome

# Android
flutter run -d android
```

### 3. Ejecutar pruebas y análisis

```bash
flutter analyze
flutter test
```

---

## Tecnologías utilizadas

<p align="center">
  <a href="https://skillicons.dev"><img src="https://skillicons.dev/icons?i=flutter,dart,windows,vscode,git,github,youtube&theme=dark&perline=8" alt="Tecnologías del proyecto" /></a>
</p>

| Tecnología | Uso | Icono |
|-----------|-----|-------|
| **Flutter / Dart** | Framework y lenguaje de la aplicación | <img src="https://skillicons.dev/icons?i=flutter,dart&theme=dark" height="28" alt="Flutter Dart" /> |
| **Material 3** | Interfaz de usuario | <img src="https://skillicons.dev/icons?i=androidstudio&theme=dark" height="28" alt="Android Studio" /> |
| **http** | Consumo de [Rick and Morty API](https://rickandmortyapi.com/) | <img src="https://skillicons.dev/icons?i=postman&theme=dark" height="28" alt="API REST" /> |
| **youtube_player_iframe** | Reproducción de videos dentro de la app | <img src="https://skillicons.dev/icons?i=youtube&theme=dark" height="28" alt="YouTube" /> |
| **url_launcher** | Enlaces de contacto en Contrátame | <img src="https://skillicons.dev/icons?i=chrome&theme=dark" height="28" alt="Enlaces web" /> |

> Iconos generados con [Skill Icons](https://skillicons.dev/).

---

## Autor

- **Nombre:** Christian Gil
- **Matrícula:** 2012-1036

---

## Créditos

<div align="center">

<img src="assets/images/rickverse_logo_transparent.png" width="200" alt="Logo RickVerse" />

<br /><br />

<img src="assets/images/rick-y-morty-fanart.jpg" width="720" alt="Arte de Rick and Morty usado en el carrusel de la app" />

<p><em>Imagen del carrusel de portada — RickVerse</em></p>

</div>

Proyecto desarrollado como parte de la materia **Introducción al Desarrollo de Aplicaciones Móviles**, impartida por el profesor **Amadis Suárez Genao**.

Consulta el [Aviso legal (NOTICE)](#aviso-legal-notice) para el alcance de la licencia y el uso de contenido de terceros.

---

## Licencia

El **código fuente** de este repositorio se distribuye bajo la [licencia MIT](LICENSE).

---

## Aviso legal (NOTICE)

> El código fuente se distribuye bajo MIT. Las imágenes, marcas y contenido audiovisual de **Rick and Morty** pertenecen a sus respectivos titulares y se usan **únicamente con fines educativos**.

| Contenido | Titular / origen | Alcance de la licencia MIT |
|-----------|------------------|----------------------------|
| Código Flutter (`lib/`, tests, configuración) | Christian Gil | Cubierto por MIT |
| Imágenes locales (`assets/images/`) | Varios autores / fanart | **No** cubierto — uso académico |
| Personajes e imágenes desde API | [Rick and Morty API](https://rickandmortyapi.com/) | **No** cubierto — datos de terceros |
| Videos embebidos | YouTube / titulares del contenido | **No** cubierto — reproducción in-app con fines educativos |
| Marca **Rick and Morty** | Adult Swim / Warner Bros. Discovery | **No** cubierto — marca registrada de terceros |

Esta aplicación es un **proyecto académico sin fines comerciales**, desarrollado para la materia **Introducción al Desarrollo de Aplicaciones Móviles** (ITLA). No está afiliada, aprobada ni patrocinada por Adult Swim, Warner Bros. ni por los creadores oficiales de la serie.
