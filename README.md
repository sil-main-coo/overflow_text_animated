# Installing

### 1. Depend on it

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  overflow_text_animated: ^0.0.1
```

### 2. Install it

You can install packages from the command line:

with `pub`:

```
$ pub get
```

with `Flutter`:

```
$ flutter pub get
```

### 3. Import it

Now in your `Dart` code, you can use:

```dart
import 'package:overflow_text_animated/overflow_text_animated.dart';
```

# Usage

<img src="https://github.com/sil-main-coo/overflow_text_animated/blob/main/display/example.gif?raw=true" align = "left"/>

`OverflowTextAnimated` is a _Stateful Widget_.
Include it in your `build` method like:

```dart
OverflowTextAnimated(
  description,
  style: descriptionStyle,
  curve: Curves.fastEaseInToSlowEaseOut,
  animateDuration: Duration(milliseconds: 1500),
  delay: Duration(milliseconds: 500),
)
```

OverflowTextAnimated is used as default text widget. It has many configurable properties, including:

- `text` - required properties
- `style` – style of text
- `curve` – motion curves of animation effects
- `animateDuration` – is the duration of the animation
- `delay` – is the break time between 2 animations

**Note:** You might come up with an issue that the `text` does not get updated with `setState` as shown [here](https://github.com/aagarwal1012/Animated-Text-Kit/issues/27). The solution to this, is a key that changes based on the text. For reference, watch [this](https://www.youtube.com/watch?v=kn0EOS-ZiIc) video.