package hx.at.dotpoint.validation;

import haxe.macro.Type.TConstant;

class Assert {
  //
  public static inline function isFalse( value:Bool ):Bool {
    if( value )
      throw "expression was expected to be false (but is true)";

    return value;
  }

  //
  public static inline function isTrue( value:Bool ):Bool {
    if( !value )
      throw "expression was expected to be true (but is false)";

    return value;
  }

  // ---------------------------------------------------------------------------------------- //
  // ---------------------------------------------------------------------------------------- //
  // null / empty

  //
  public static inline function isNull<T>( value:T ):T {
    if( value != null )
      throw "value must be null";

    return value;
  }

  //
  public static inline function notNull<T>( value:T ):T {
    if( value == null )
      throw "value must not be null";

    return value;
  }  

  //
  public static inline function notEmpty<T:{var length(default, null):Int;}>( value:T ):T {
    if( value == null )
      throw "value must not be null";

    if( value.length == 0 )
      throw "value must not be empty";

    return value;
  }

  // ---------------------------------------------------------------------------------------- //
  // ---------------------------------------------------------------------------------------- //
  // value bounds

  //
  public static inline function isMinInclusive<T:Float>( value:T, minimum:Float ):T {
    if( value < minimum )
      throw '$value was not expected to be smaller than $minimum';

    return value;
  }

  //
  public static inline function isMinExclusive<T:Float>( value:T, minimum:Float ):T {
    if( value <= minimum )
      throw '$value was not expected to be smaller than, or equal $minimum';

    return value;
  }

  //
  public static inline function isMaxInclusive<T:Float>( value:T, maximum:Float ):T {
    if( value > maximum )
      throw '$value was not expected to be greater than $maximum';

    return value;
  }

  //
  public static inline function isMaxExclusive<T:Float>( value:T, maximum:Float ):T {
    if( value >= maximum )
      throw '$value was not expected to be greater than, or equal $maximum';

    return value;
  }
}