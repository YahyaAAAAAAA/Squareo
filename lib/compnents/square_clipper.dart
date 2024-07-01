import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

class SquareAndroidClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    double width = size.width / 15;
    double height = size.height / 15;
    path_0.moveTo(7.5 * width, 4 * height);
    path_0.cubicTo(6.44445 * width, 4 * height, 5.44766 * width,
        4.25161 * height, 4.56634 * width, 4.69812 * height);
    path_0.lineTo(2.91603 * width, 2.22266 * height);
    path_0.lineTo(2.08398 * width, 2.77736 * height);
    path_0.lineTo(3.71104 * width, 5.21794 * height);
    path_0.cubicTo(2.06927 * width, 6.39771 * height, 1 * width,
        8.32399 * height, 1 * width, 10.5 * height);
    path_0.lineTo(1 * width, 13 * height);
    path_0.lineTo(14 * width, 13 * height);
    path_0.lineTo(14 * width, 10.5 * height);
    path_0.cubicTo(14 * width, 8.32399 * height, 12.9307 * width,
        6.39772 * height, 11.289 * width, 5.21795 * height);
    path_0.lineTo(12.916 * width, 2.77736 * height);
    path_0.lineTo(12.084 * width, 2.22266 * height);
    path_0.lineTo(10.4337 * width, 4.69812 * height);
    path_0.cubicTo(9.55235 * width, 4.25161 * height, 8.55556 * width,
        4 * height, 7.5 * width, 4 * height);
    path_0.close();
    path_0.moveTo(5 * width, 10 * height);
    path_0.lineTo(3 * width, 10 * height);
    path_0.lineTo(3 * width, 9 * height);
    path_0.lineTo(4 * width, 9 * height);
    path_0.lineTo(4 * width, 10 * height);

    path_0.close();
    path_0.moveTo(10 * width, 10 * height);
    path_0.lineTo(11 * width, 10 * height);
    path_0.lineTo(11 * width, 9 * height);
    path_0.lineTo(12 * width, 9 * height);
    path_0.lineTo(12 * width, 10 * height);
    path_0.close();

    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class SquareHeartClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    double width = size.width / 15;
    double height = size.height / 15;
    path_0.moveTo(4.03553 * width, 1 * height);
    path_0.cubicTo(1.80677 * width, 1 * height, 0 * width, 2.80677 * height,
        0 * width, 5.03553 * height);
    path_0.cubicTo(0 * width, 6.10582 * height, 0.42517 * width,
        7.13228 * height, 1.18198 * width, 7.88909 * height);
    path_0.lineTo(7.14645 * width, 13.8536 * height);
    path_0.cubicTo(7.34171 * width, 14.0488 * height, 7.65829 * width,
        14.0488 * height, 7.85355 * width, 13.8536 * height);
    path_0.lineTo(13.818 * width, 7.88909 * height);
    path_0.cubicTo(14.5748 * width, 7.13228 * height, 15 * width,
        6.10582 * height, 15 * width, 5.03553 * height);
    path_0.cubicTo(15 * width, 2.80677 * height, 13.1932 * width, 1 * height,
        10.9645 * width, 1 * height);
    path_0.cubicTo(9.89418 * width, 1 * height, 8.86772 * width,
        1.42517 * height, 8.11091 * width, 2.18198 * height);
    path_0.lineTo(7.5 * width, 2.79289 * height);
    path_0.lineTo(6.88909 * width, 2.18198 * height);
    path_0.cubicTo(6.13228 * width, 1.42517 * height, 5.10582 * width,
        1 * height, 4.03553 * width, 1 * height);
    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class SquareStarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double width = size.width / 64;
    double height = size.height / 70;
    Path path_0 = Path();
    path_0.moveTo(62.799 * width, 23.737 * height);
    path_0.cubicTo(62.329 * width, 22.337999999999997 * height, 61.118 * width,
        21.317999999999998 * height, 59.66 * width, 21.095 * height);
    path_0.lineTo(42.690999999999995 * width, 18.502 * height);
    path_0.lineTo(35.069 * width, 2.265 * height);
    path_0.cubicTo(34.419 * width, 0.881 * height, 33.03 * width, 0 * height,
        31.504 * width, 0 * height);
    path_0.cubicTo(29.977 * width, 0 * height, 28.589000000000002 * width,
        0.881 * height, 27.939 * width, 2.265 * height);
    path_0.lineTo(20.316 * width, 18.503 * height);
    path_0.lineTo(3.347 * width, 21.096 * height);
    path_0.cubicTo(1.889 * width, 21.319 * height, 0.6779999999999999 * width,
        22.338 * height, 0.20900000000000007 * width, 23.738 * height);
    path_0.cubicTo(
        -0.2599999999999999 * width,
        25.137999999999998 * height,
        0.09400000000000007 * width,
        26.68 * height,
        1.125 * width,
        27.738 * height);
    path_0.lineTo(13.517 * width, 40.445 * height);
    path_0.lineTo(10.581999999999999 * width, 58.422 * height);
    path_0.cubicTo(
        10.34 * width,
        59.91 * height,
        10.970999999999998 * width,
        61.406 * height,
        12.201999999999998 * width,
        62.275999999999996 * height);
    path_0.cubicTo(
        13.431999999999999 * width,
        63.145999999999994 * height,
        15.055999999999997 * width,
        63.233999999999995 * height,
        16.378999999999998 * width,
        62.504 * height);
    path_0.lineTo(31.504999999999995 * width, 54.138999999999996 * height);
    path_0.lineTo(46.63099999999999 * width, 62.504 * height);
    path_0.cubicTo(
        47.227999999999994 * width,
        62.833999999999996 * height,
        47.88499999999999 * width,
        62.995999999999995 * height,
        48.538999999999994 * width,
        62.995999999999995 * height);
    path_0.cubicTo(
        49.334999999999994 * width,
        62.995999999999995 * height,
        50.13099999999999 * width,
        62.754 * height,
        50.80799999999999 * width,
        62.275999999999996 * height);
    path_0.cubicTo(
        52.038999999999994 * width,
        61.407 * height,
        52.66899999999999 * width,
        59.910999999999994 * height,
        52.42699999999999 * width,
        58.422 * height);
    path_0.lineTo(49.49199999999999 * width, 40.44499999999999 * height);
    path_0.lineTo(61.88499999999999 * width, 27.737999999999992 * height);
    path_0.cubicTo(62.914 * width, 26.68 * height, 63.268 * width,
        25.138 * height, 62.799 * width, 23.737 * height);
    path_0.close();

    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class SquareDiamondClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double width = size.width / 24;
    double height = size.height / 24;

    Path path_0 = Path();
    path_0.moveTo(21.7704 * width, 9.79844 * height);
    path_0.lineTo(20.9704 * width, 7.99844 * height);
    path_0.lineTo(19.2104 * width, 4.03844 * height);
    path_0.cubicTo(18.7404 * width, 2.99844 * height, 18.0004 * width,
        2.14844 * height, 16.3004 * width, 2.14844 * height);
    path_0.lineTo(7.70044 * width, 2.14844 * height);
    path_0.cubicTo(6.00044 * width, 2.14844 * height, 5.26044 * width,
        2.99844 * height, 4.79044 * width, 4.03844 * height);
    path_0.lineTo(3.03044 * width, 7.99844 * height);
    path_0.lineTo(2.23044 * width, 9.79844 * height);
    path_0.cubicTo(1.77044 * width, 10.8484 * height, 2.02044 * width,
        12.3884 * height, 2.79044 * width, 13.2384 * height);
    path_0.lineTo(9.64044 * width, 20.7784 * height);
    path_0.cubicTo(10.9404 * width, 22.2084 * height, 13.0604 * width,
        22.2084 * height, 14.3604 * width, 20.7784 * height);
    path_0.lineTo(21.2104 * width, 13.2384 * height);
    path_0.cubicTo(21.9804 * width, 12.3884 * height, 22.2304 * width,
        10.8484 * height, 21.7704 * width, 9.79844 * height);
    path_0.close();

    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class SquareSunClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;
    final Path path = parseSvgPathData(
        "M23,11H18.92a6.924,6.924,0,0,0-.429-1.607l3.527-2.044a1,1,0,1,0-1-1.731l-3.53,2.047a7.062,7.062,0,0,0-1.149-1.15l2.046-3.531a1,1,0,0,0-1.731-1L14.607,5.509A6.9,6.9,0,0,0,13,5.08V1a1,1,0,0,0-2,0V5.08a6.9,6.9,0,0,0-1.607.429L7.349,1.982a1,1,0,0,0-1.731,1L7.664,6.515a7.062,7.062,0,0,0-1.149,1.15L2.985,5.618a1,1,0,1,0-1,1.731L5.509,9.393A6.924,6.924,0,0,0,5.08,11H1a1,1,0,0,0,0,2H5.08a6.924,6.924,0,0,0,.429,1.607L1.982,16.651a1,1,0,1,0,1,1.731l3.53-2.047a7.062,7.062,0,0,0,1.149,1.15L5.618,21.016a1,1,0,0,0,1.731,1l2.044-3.527A6.947,6.947,0,0,0,11,18.92V23a1,1,0,0,0,2,0V18.92a6.947,6.947,0,0,0,1.607-.429l2.044,3.527a1,1,0,0,0,1.731-1l-2.046-3.531a7.062,7.062,0,0,0,1.149-1.15l3.53,2.047a1,1,0,1,0,1-1.731l-3.527-2.044A6.924,6.924,0,0,0,18.92,13H23A1,1,0,0,0,23,11Z");
    final Rect pathBounds = path.getBounds();
    final Matrix4 matrix4 = Matrix4.identity();
    matrix4.scale(width / pathBounds.width, height / pathBounds.height);

    return path.transform(matrix4.storage);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class SquareSparkleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;
    final Path path = parseSvgPathData(
        "m12.939,23.371c-.345.839-1.533.839-1.878,0l-2.89-7.542L.629,12.939c-.839-.345-.839-1.533,0-1.878l7.542-2.89L11.061.629c.345-.839,1.533-.839,1.878,0l2.89,7.542,7.542,2.89c.839.345.839,1.533,0,1.878l-7.542,2.89-2.89,7.542ZM4.778,7.405l1.861-.766.77-1.871-3.922-2.602c-.866-.572-1.894.455-1.322,1.322l2.612,3.917Zm12.583-.766l1.861.766,2.612-3.917c.572-.866-.456-1.894-1.322-1.322l-3.922,2.602.77,1.871Zm1.867,9.954l-1.867.769-.766,1.861,3.918,2.6c.866.572,1.894-.455,1.322-1.322l-2.606-3.907Zm-12.59.769l-1.867-.769-2.606,3.907c-.572.866.456,1.894,1.322,1.322l3.918-2.6-.766-1.861Z");
    final Rect pathBounds = path.getBounds();
    final Matrix4 matrix4 = Matrix4.identity();
    matrix4.scale(width / pathBounds.width, height / pathBounds.height);

    return path.transform(matrix4.storage);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class SquarePyramidClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;
    final Path path = parseSvgPathData(
        "M20.036,24H3.964A3.955,3.955,0,0,1,.422,18.267L8.459,2.189A3.932,3.932,0,0,1,11.736.008a3.977,3.977,0,0,1,3.805,2.181l8.037,16.078A3.961,3.961,0,0,1,20.036,24Z");
    final Rect pathBounds = path.getBounds();
    final Matrix4 matrix4 = Matrix4.identity();
    matrix4.scale(width / pathBounds.width, height / pathBounds.height);

    return path.transform(matrix4.storage);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
