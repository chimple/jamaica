// GENERATED CODE - DO NOT MODIFY BY HAND

part of game_status;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GameStatus extends GameStatus {
  @override
  final int currentLevel;
  @override
  final int highestLevel;
  @override
  final int maxScore;
  @override
  final bool open;

  factory _$GameStatus([void updates(GameStatusBuilder b)]) =>
      (new GameStatusBuilder()..update(updates)).build();

  _$GameStatus._(
      {this.currentLevel, this.highestLevel, this.maxScore, this.open})
      : super._() {
    if (currentLevel == null) {
      throw new BuiltValueNullFieldError('GameStatus', 'currentLevel');
    }
    if (highestLevel == null) {
      throw new BuiltValueNullFieldError('GameStatus', 'highestLevel');
    }
    if (maxScore == null) {
      throw new BuiltValueNullFieldError('GameStatus', 'maxScore');
    }
    if (open == null) {
      throw new BuiltValueNullFieldError('GameStatus', 'open');
    }
  }

  @override
  GameStatus rebuild(void updates(GameStatusBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  GameStatusBuilder toBuilder() => new GameStatusBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GameStatus &&
        currentLevel == other.currentLevel &&
        highestLevel == other.highestLevel &&
        maxScore == other.maxScore &&
        open == other.open;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, currentLevel.hashCode), highestLevel.hashCode),
            maxScore.hashCode),
        open.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GameStatus')
          ..add('currentLevel', currentLevel)
          ..add('highestLevel', highestLevel)
          ..add('maxScore', maxScore)
          ..add('open', open))
        .toString();
  }
}

class GameStatusBuilder implements Builder<GameStatus, GameStatusBuilder> {
  _$GameStatus _$v;

  int _currentLevel;
  int get currentLevel => _$this._currentLevel;
  set currentLevel(int currentLevel) => _$this._currentLevel = currentLevel;

  int _highestLevel;
  int get highestLevel => _$this._highestLevel;
  set highestLevel(int highestLevel) => _$this._highestLevel = highestLevel;

  int _maxScore;
  int get maxScore => _$this._maxScore;
  set maxScore(int maxScore) => _$this._maxScore = maxScore;

  bool _open;
  bool get open => _$this._open;
  set open(bool open) => _$this._open = open;

  GameStatusBuilder();

  GameStatusBuilder get _$this {
    if (_$v != null) {
      _currentLevel = _$v.currentLevel;
      _highestLevel = _$v.highestLevel;
      _maxScore = _$v.maxScore;
      _open = _$v.open;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GameStatus other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$GameStatus;
  }

  @override
  void update(void updates(GameStatusBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$GameStatus build() {
    final _$result = _$v ??
        new _$GameStatus._(
            currentLevel: currentLevel,
            highestLevel: highestLevel,
            maxScore: maxScore,
            open: open);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
