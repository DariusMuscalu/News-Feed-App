import 'package:flutter/material.dart';

import '../../images/svg.dart';

// Main button used inside our app which has a default design used for keeping
// consistency through the app but it can also be customizable.
class Button extends StatefulWidget {
  final Widget? child;
  final String? name;
  final void Function() onTap;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? height;
  final String? iconUrl;
  final bool iconIsLast;
  final double? iconWidth;
  final Color? iconColor;
  final EdgeInsets? iconPadding;
  final double? labelFontSize;
  final FontWeight? fontWeight;
  final TextStyle? textStyle;
  final Color? color;
  final Color? hoverColor;
  final Color? bgrColor;
  final Color? hoverBgrColor;
  final bool disableShadow;
  final bool changeBgrOnHover;
  final Color? borderColor;
  final double borderRadius;
  final double? borderTopRight;
  final double? borderBottomRight;
  final double? borderTopLeft;
  final double? borderBottomLeft;

  // If the buttons are used in a Row or a Wrap we need to shrink them
  // to occupy the least amount of available space.
  // Can be useful also when we want to align buttons in a column
  // without the buttons stretching to the parent's max width.
  final bool shrink;

  // By default, the content inside the button is centered
  // Make it false to stretch the space between text and icon
  final bool spaceBetweenElements;

  // By default buttons don't have border, that's the preferred style
  // If needed we can add borders on demand
  final bool showBorder;

  // By default, buttons will have a small SVG icon
  // For buttons that does not require icons, this can be set to false
  final bool showIcon;

  const Button({
    this.name,
    this.child,
    required this.onTap,
    this.padding,
    this.margin,
    this.iconUrl,
    this.iconIsLast = false,
    this.iconWidth,
    this.labelFontSize,
    this.iconColor,
    this.iconPadding,
    this.color,
    this.hoverColor,
    this.bgrColor,
    this.hoverBgrColor,
    this.borderColor,
    this.fontWeight,
    this.textStyle,
    this.height,
    this.disableShadow = false,
    this.borderRadius = 20,
    this.borderBottomLeft,
    this.borderBottomRight,
    this.borderTopLeft,
    this.borderTopRight,
    this.shrink = false,
    this.showBorder = false,
    this.showIcon = true,
    this.spaceBetweenElements = true,
    this.changeBgrOnHover = true,
    Key? key,
  }) : super(key: key);

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return _decoratedInkwell(
      children: [
        if (widget.iconUrl != null && !widget.iconIsLast && widget.showIcon)
          _icon(),
        if (widget.name != null) _label(),
        if (widget.child != null) widget.child!,
        if (widget.iconUrl != null && widget.iconIsLast && widget.showIcon)
          _icon(),
      ],
    );
  }

  Widget _decoratedInkwell({required List<Widget> children}) {
    final decoration = BoxDecoration(
      color: widget.bgrColor ?? Colors.white,
      borderRadius: _borderRadius(),
      border: widget.showBorder
          ? Border.all(
              color: widget.borderColor ?? Colors.red,
            )
          : null,
      boxShadow: [
        BoxShadow(
          color: widget.disableShadow
              ? Colors.black.withOpacity(_isHovered ? 0.25 : 0)
              : Colors.transparent,
          blurRadius: 8,
        ),
      ],
    );

    return Container(
      margin: widget.margin ?? EdgeInsets.zero,
      decoration: decoration,
      child: ClipRRect(
        borderRadius: _borderRadius(),
        child: InkWell(
          onHover: (_) => {
            setState(() {
              _isHovered = !_isHovered;
            })
          },
          onTap: widget.onTap,
          child: Container(
            height: widget.height,
            padding:
                widget.padding ?? const EdgeInsets.fromLTRB(22, 7.5, 22, 7.5),
            child: Row(
              mainAxisSize: widget.shrink ? MainAxisSize.min : MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: widget.spaceBetweenElements
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceBetween,
              children: children,
            ),
          ),
        ),
      ),
    );
  }

  BorderRadius _borderRadius() => BorderRadius.only(
        topRight: Radius.circular(
          widget.borderTopRight ?? widget.borderRadius,
        ),
        bottomRight: Radius.circular(
          widget.borderBottomRight ?? widget.borderRadius,
        ),
        topLeft: Radius.circular(
          widget.borderTopLeft ?? widget.borderRadius,
        ),
        bottomLeft: Radius.circular(
          widget.borderBottomLeft ?? widget.borderRadius,
        ),
      );

  Widget _icon() => Container(
        padding: widget.iconPadding ??
            (widget.iconIsLast
                ? EdgeInsets.only(left: widget.name != null ? 8 : 0)
                : EdgeInsets.only(right: widget.name != null ? 8 : 0)),
        child: Svg(
          iconUrl: widget.iconUrl ?? '',
          color: widget.iconColor ??
              (_isHovered ? widget.hoverColor : widget.color ?? Colors.black),
          width: widget.iconWidth ?? 18,
        ),
      );

  Widget _label() => Text(
        widget.name!,
        style: widget.textStyle ??
            TextStyle(
              color:
                  _isHovered ? widget.hoverColor : widget.color ?? Colors.black,
              fontSize: widget.labelFontSize ?? 14,
              height: 1.2,
              fontWeight: widget.fontWeight ?? FontWeight.w500,
            ),
      );
}
