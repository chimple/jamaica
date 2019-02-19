// GENERATED CODE - DO NOT MODIFY BY HAND

part of user_profile;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserProfile extends UserProfile {
  @override
  final String name;
  @override
  final String currentTheme;
  @override
  final BuiltMap<String, GameStatus> gameStatuses;
  @override
  final BuiltMap<String, int> items;
  @override
  final BuiltMap<String, String> accessories;

  factory _$UserProfile([void updates(UserProfileBuilder b)]) =>
      (new UserProfileBuilder()..update(updates)).build() as _$UserProfile;

  _$UserProfile._(
      {this.name,
      this.currentTheme,
      this.gameStatuses,
      this.items,
      this.accessories})
      : super._() {
    if (name == null) {
      throw new BuiltValueNullFieldError('UserProfile', 'name');
    }
    if (currentTheme == null) {
      throw new BuiltValueNullFieldError('UserProfile', 'currentTheme');
    }
    if (gameStatuses == null) {
      throw new BuiltValueNullFieldError('UserProfile', 'gameStatuses');
    }
    if (items == null) {
      throw new BuiltValueNullFieldError('UserProfile', 'items');
    }
    if (accessories == null) {
      throw new BuiltValueNullFieldError('UserProfile', 'accessories');
    }
  }

  @override
  UserProfile rebuild(void updates(UserProfileBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  _$UserProfileBuilder toBuilder() => new _$UserProfileBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserProfile &&
        name == other.name &&
        currentTheme == other.currentTheme &&
        gameStatuses == other.gameStatuses &&
        items == other.items &&
        accessories == other.accessories;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, name.hashCode), currentTheme.hashCode),
                gameStatuses.hashCode),
            items.hashCode),
        accessories.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserProfile')
          ..add('name', name)
          ..add('currentTheme', currentTheme)
          ..add('gameStatuses', gameStatuses)
          ..add('items', items)
          ..add('accessories', accessories))
        .toString();
  }
}

class _$UserProfileBuilder extends UserProfileBuilder {
  _$UserProfile _$v;

  @override
  String get name {
    _$this;
    return super.name;
  }

  @override
  set name(String name) {
    _$this;
    super.name = name;
  }

  @override
  String get currentTheme {
    _$this;
    return super.currentTheme;
  }

  @override
  set currentTheme(String currentTheme) {
    _$this;
    super.currentTheme = currentTheme;
  }

  @override
  BuiltMap<String, GameStatus> get gameStatuses {
    _$this;
    return super.gameStatuses;
  }

  @override
  set gameStatuses(BuiltMap<String, GameStatus> gameStatuses) {
    _$this;
    super.gameStatuses = gameStatuses;
  }

  @override
  BuiltMap<String, int> get items {
    _$this;
    return super.items;
  }

  @override
  set items(BuiltMap<String, int> items) {
    _$this;
    super.items = items;
  }

  @override
  BuiltMap<String, String> get accessories {
    _$this;
    return super.accessories;
  }

  @override
  set accessories(BuiltMap<String, String> accessories) {
    _$this;
    super.accessories = accessories;
  }

  _$UserProfileBuilder() : super._();

  UserProfileBuilder get _$this {
    if (_$v != null) {
      super.name = _$v.name;
      super.currentTheme = _$v.currentTheme;
      super.gameStatuses = _$v.gameStatuses;
      super.items = _$v.items;
      super.accessories = _$v.accessories;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserProfile other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$UserProfile;
  }

  @override
  void update(void updates(UserProfileBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$UserProfile build() {
    final _$result = _$v ??
        new _$UserProfile._(
            name: name,
            currentTheme: currentTheme,
            gameStatuses: gameStatuses,
            items: items,
            accessories: accessories);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
