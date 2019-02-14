// GENERATED CODE - DO NOT MODIFY BY HAND

part of game_config;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GameConfig extends GameConfig {
  @override
  final String name;
  @override
  final String image;
  @override
  final int levels;

  factory _$GameConfig([void updates(GameConfigBuilder b)]) =>
      (new GameConfigBuilder()..update(updates)).build();

  _$GameConfig._({this.name, this.image, this.levels}) : super._() {
    if (name == null) {
      throw new BuiltValueNullFieldError('GameConfig', 'name');
    }
    if (image == null) {
      throw new BuiltValueNullFieldError('GameConfig', 'image');
    }
    if (levels == null) {
      throw new BuiltValueNullFieldError('GameConfig', 'levels');
    }
  }

  @override
  GameConfig rebuild(void updates(GameConfigBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  GameConfigBuilder toBuilder() => new GameConfigBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GameConfig &&
        name == other.name &&
        image == other.image &&
        levels == other.levels;
  }

  @override
  int get hashCode {
    return $jf(
      $jc($jc($jc(0, name.hashCode), image.hashCode), levels.hashCode),
    );
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GameConfig')
          ..add('name', name)
          ..add('image', image)
          ..add('levels', levels))
        .toString();
  }
}

class GameConfigBuilder implements Builder<GameConfig, GameConfigBuilder> {
  _$GameConfig _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _image;
  String get image => _$this._image;
  set image(String image) => _$this._image = image;

  int _levels;
  int get levels => _$this._levels;
  set levels(int levels) => _$this._levels = levels;

  GameConfigBuilder();

  GameConfigBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _image = _$v.image;
      _levels = _$v.levels;

      _$v = null;
    }
    return this;
  }

  @override
  void replace(GameConfig other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$GameConfig;
  }

  @override
  void update(void updates(GameConfigBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$GameConfig build() {
    final _$result = _$v ??
        new _$GameConfig._(
          name: name,
          image: image,
          levels: levels,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
