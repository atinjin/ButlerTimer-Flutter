// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSessionCollection on Isar {
  IsarCollection<Session> get sessions => this.collection();
}

const SessionSchema = CollectionSchema(
  name: r'Session',
  id: 4817823809690647594,
  properties: {
    r'dateFinished': PropertySchema(
      id: 0,
      name: r'dateFinished',
      type: IsarType.dateTime,
    ),
    r'dateStarted': PropertySchema(
      id: 1,
      name: r'dateStarted',
      type: IsarType.dateTime,
    ),
    r'totalSelectionTime': PropertySchema(
      id: 2,
      name: r'totalSelectionTime',
      type: IsarType.double,
    )
  },
  estimateSize: _sessionEstimateSize,
  serialize: _sessionSerialize,
  deserialize: _sessionDeserialize,
  deserializeProp: _sessionDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'questionSet': LinkSchema(
      id: 8827880695815886021,
      name: r'questionSet',
      target: r'QuestionSet',
      single: true,
    ),
    r'questionResults': LinkSchema(
      id: 4184533998479800365,
      name: r'questionResults',
      target: r'QuestionResult',
      single: false,
      linkName: r'session',
    )
  },
  embeddedSchemas: {},
  getId: _sessionGetId,
  getLinks: _sessionGetLinks,
  attach: _sessionAttach,
  version: '3.1.0+1',
);

int _sessionEstimateSize(
  Session object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _sessionSerialize(
  Session object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.dateFinished);
  writer.writeDateTime(offsets[1], object.dateStarted);
  writer.writeDouble(offsets[2], object.totalSelectionTime);
}

Session _sessionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Session();
  object.dateFinished = reader.readDateTimeOrNull(offsets[0]);
  object.dateStarted = reader.readDateTime(offsets[1]);
  object.id = id;
  object.totalSelectionTime = reader.readDouble(offsets[2]);
  return object;
}

P _sessionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _sessionGetId(Session object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _sessionGetLinks(Session object) {
  return [object.questionSet, object.questionResults];
}

void _sessionAttach(IsarCollection<dynamic> col, Id id, Session object) {
  object.id = id;
  object.questionSet
      .attach(col, col.isar.collection<QuestionSet>(), r'questionSet', id);
  object.questionResults.attach(
      col, col.isar.collection<QuestionResult>(), r'questionResults', id);
}

extension SessionQueryWhereSort on QueryBuilder<Session, Session, QWhere> {
  QueryBuilder<Session, Session, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SessionQueryWhere on QueryBuilder<Session, Session, QWhereClause> {
  QueryBuilder<Session, Session, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Session, Session, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Session, Session, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Session, Session, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Session, Session, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SessionQueryFilter
    on QueryBuilder<Session, Session, QFilterCondition> {
  QueryBuilder<Session, Session, QAfterFilterCondition> dateFinishedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dateFinished',
      ));
    });
  }

  QueryBuilder<Session, Session, QAfterFilterCondition>
      dateFinishedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dateFinished',
      ));
    });
  }

  QueryBuilder<Session, Session, QAfterFilterCondition> dateFinishedEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateFinished',
        value: value,
      ));
    });
  }

  QueryBuilder<Session, Session, QAfterFilterCondition> dateFinishedGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateFinished',
        value: value,
      ));
    });
  }

  QueryBuilder<Session, Session, QAfterFilterCondition> dateFinishedLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateFinished',
        value: value,
      ));
    });
  }

  QueryBuilder<Session, Session, QAfterFilterCondition> dateFinishedBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateFinished',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Session, Session, QAfterFilterCondition> dateStartedEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateStarted',
        value: value,
      ));
    });
  }

  QueryBuilder<Session, Session, QAfterFilterCondition> dateStartedGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateStarted',
        value: value,
      ));
    });
  }

  QueryBuilder<Session, Session, QAfterFilterCondition> dateStartedLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateStarted',
        value: value,
      ));
    });
  }

  QueryBuilder<Session, Session, QAfterFilterCondition> dateStartedBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateStarted',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Session, Session, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Session, Session, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Session, Session, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Session, Session, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Session, Session, QAfterFilterCondition>
      totalSelectionTimeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalSelectionTime',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Session, Session, QAfterFilterCondition>
      totalSelectionTimeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalSelectionTime',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Session, Session, QAfterFilterCondition>
      totalSelectionTimeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalSelectionTime',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Session, Session, QAfterFilterCondition>
      totalSelectionTimeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalSelectionTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension SessionQueryObject
    on QueryBuilder<Session, Session, QFilterCondition> {}

extension SessionQueryLinks
    on QueryBuilder<Session, Session, QFilterCondition> {
  QueryBuilder<Session, Session, QAfterFilterCondition> questionSet(
      FilterQuery<QuestionSet> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'questionSet');
    });
  }

  QueryBuilder<Session, Session, QAfterFilterCondition> questionSetIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'questionSet', 0, true, 0, true);
    });
  }

  QueryBuilder<Session, Session, QAfterFilterCondition> questionResults(
      FilterQuery<QuestionResult> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'questionResults');
    });
  }

  QueryBuilder<Session, Session, QAfterFilterCondition>
      questionResultsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'questionResults', length, true, length, true);
    });
  }

  QueryBuilder<Session, Session, QAfterFilterCondition>
      questionResultsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'questionResults', 0, true, 0, true);
    });
  }

  QueryBuilder<Session, Session, QAfterFilterCondition>
      questionResultsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'questionResults', 0, false, 999999, true);
    });
  }

  QueryBuilder<Session, Session, QAfterFilterCondition>
      questionResultsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'questionResults', 0, true, length, include);
    });
  }

  QueryBuilder<Session, Session, QAfterFilterCondition>
      questionResultsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'questionResults', length, include, 999999, true);
    });
  }

  QueryBuilder<Session, Session, QAfterFilterCondition>
      questionResultsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'questionResults', lower, includeLower, upper, includeUpper);
    });
  }
}

extension SessionQuerySortBy on QueryBuilder<Session, Session, QSortBy> {
  QueryBuilder<Session, Session, QAfterSortBy> sortByDateFinished() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateFinished', Sort.asc);
    });
  }

  QueryBuilder<Session, Session, QAfterSortBy> sortByDateFinishedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateFinished', Sort.desc);
    });
  }

  QueryBuilder<Session, Session, QAfterSortBy> sortByDateStarted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateStarted', Sort.asc);
    });
  }

  QueryBuilder<Session, Session, QAfterSortBy> sortByDateStartedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateStarted', Sort.desc);
    });
  }

  QueryBuilder<Session, Session, QAfterSortBy> sortByTotalSelectionTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSelectionTime', Sort.asc);
    });
  }

  QueryBuilder<Session, Session, QAfterSortBy> sortByTotalSelectionTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSelectionTime', Sort.desc);
    });
  }
}

extension SessionQuerySortThenBy
    on QueryBuilder<Session, Session, QSortThenBy> {
  QueryBuilder<Session, Session, QAfterSortBy> thenByDateFinished() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateFinished', Sort.asc);
    });
  }

  QueryBuilder<Session, Session, QAfterSortBy> thenByDateFinishedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateFinished', Sort.desc);
    });
  }

  QueryBuilder<Session, Session, QAfterSortBy> thenByDateStarted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateStarted', Sort.asc);
    });
  }

  QueryBuilder<Session, Session, QAfterSortBy> thenByDateStartedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateStarted', Sort.desc);
    });
  }

  QueryBuilder<Session, Session, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Session, Session, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Session, Session, QAfterSortBy> thenByTotalSelectionTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSelectionTime', Sort.asc);
    });
  }

  QueryBuilder<Session, Session, QAfterSortBy> thenByTotalSelectionTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSelectionTime', Sort.desc);
    });
  }
}

extension SessionQueryWhereDistinct
    on QueryBuilder<Session, Session, QDistinct> {
  QueryBuilder<Session, Session, QDistinct> distinctByDateFinished() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateFinished');
    });
  }

  QueryBuilder<Session, Session, QDistinct> distinctByDateStarted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateStarted');
    });
  }

  QueryBuilder<Session, Session, QDistinct> distinctByTotalSelectionTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalSelectionTime');
    });
  }
}

extension SessionQueryProperty
    on QueryBuilder<Session, Session, QQueryProperty> {
  QueryBuilder<Session, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Session, DateTime?, QQueryOperations> dateFinishedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateFinished');
    });
  }

  QueryBuilder<Session, DateTime, QQueryOperations> dateStartedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateStarted');
    });
  }

  QueryBuilder<Session, double, QQueryOperations> totalSelectionTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalSelectionTime');
    });
  }
}
