// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_result.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetQuestionResultCollection on Isar {
  IsarCollection<QuestionResult> get questionResults => this.collection();
}

const QuestionResultSchema = CollectionSchema(
  name: r'QuestionResult',
  id: -6301597010264864575,
  properties: {
    r'isCorrect': PropertySchema(
      id: 0,
      name: r'isCorrect',
      type: IsarType.bool,
    ),
    r'questionIndex': PropertySchema(
      id: 1,
      name: r'questionIndex',
      type: IsarType.long,
    ),
    r'totalSolvingTime': PropertySchema(
      id: 2,
      name: r'totalSolvingTime',
      type: IsarType.double,
    )
  },
  estimateSize: _questionResultEstimateSize,
  serialize: _questionResultSerialize,
  deserialize: _questionResultDeserialize,
  deserializeProp: _questionResultDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'session': LinkSchema(
      id: -6631372321371741763,
      name: r'session',
      target: r'Session',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _questionResultGetId,
  getLinks: _questionResultGetLinks,
  attach: _questionResultAttach,
  version: '3.1.0+1',
);

int _questionResultEstimateSize(
  QuestionResult object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _questionResultSerialize(
  QuestionResult object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.isCorrect);
  writer.writeLong(offsets[1], object.questionIndex);
  writer.writeDouble(offsets[2], object.totalSolvingTime);
}

QuestionResult _questionResultDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = QuestionResult();
  object.id = id;
  object.isCorrect = reader.readBoolOrNull(offsets[0]);
  object.questionIndex = reader.readLong(offsets[1]);
  object.totalSolvingTime = reader.readDouble(offsets[2]);
  return object;
}

P _questionResultDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolOrNull(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _questionResultGetId(QuestionResult object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _questionResultGetLinks(QuestionResult object) {
  return [object.session];
}

void _questionResultAttach(
    IsarCollection<dynamic> col, Id id, QuestionResult object) {
  object.id = id;
  object.session.attach(col, col.isar.collection<Session>(), r'session', id);
}

extension QuestionResultQueryWhereSort
    on QueryBuilder<QuestionResult, QuestionResult, QWhere> {
  QueryBuilder<QuestionResult, QuestionResult, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension QuestionResultQueryWhere
    on QueryBuilder<QuestionResult, QuestionResult, QWhereClause> {
  QueryBuilder<QuestionResult, QuestionResult, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<QuestionResult, QuestionResult, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<QuestionResult, QuestionResult, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<QuestionResult, QuestionResult, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<QuestionResult, QuestionResult, QAfterWhereClause> idBetween(
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

extension QuestionResultQueryFilter
    on QueryBuilder<QuestionResult, QuestionResult, QFilterCondition> {
  QueryBuilder<QuestionResult, QuestionResult, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionResult, QuestionResult, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<QuestionResult, QuestionResult, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<QuestionResult, QuestionResult, QAfterFilterCondition> idBetween(
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

  QueryBuilder<QuestionResult, QuestionResult, QAfterFilterCondition>
      isCorrectIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isCorrect',
      ));
    });
  }

  QueryBuilder<QuestionResult, QuestionResult, QAfterFilterCondition>
      isCorrectIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isCorrect',
      ));
    });
  }

  QueryBuilder<QuestionResult, QuestionResult, QAfterFilterCondition>
      isCorrectEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCorrect',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionResult, QuestionResult, QAfterFilterCondition>
      questionIndexEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'questionIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionResult, QuestionResult, QAfterFilterCondition>
      questionIndexGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'questionIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionResult, QuestionResult, QAfterFilterCondition>
      questionIndexLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'questionIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionResult, QuestionResult, QAfterFilterCondition>
      questionIndexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'questionIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuestionResult, QuestionResult, QAfterFilterCondition>
      totalSolvingTimeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalSolvingTime',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<QuestionResult, QuestionResult, QAfterFilterCondition>
      totalSolvingTimeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalSolvingTime',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<QuestionResult, QuestionResult, QAfterFilterCondition>
      totalSolvingTimeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalSolvingTime',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<QuestionResult, QuestionResult, QAfterFilterCondition>
      totalSolvingTimeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalSolvingTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension QuestionResultQueryObject
    on QueryBuilder<QuestionResult, QuestionResult, QFilterCondition> {}

extension QuestionResultQueryLinks
    on QueryBuilder<QuestionResult, QuestionResult, QFilterCondition> {
  QueryBuilder<QuestionResult, QuestionResult, QAfterFilterCondition> session(
      FilterQuery<Session> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'session');
    });
  }

  QueryBuilder<QuestionResult, QuestionResult, QAfterFilterCondition>
      sessionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'session', 0, true, 0, true);
    });
  }
}

extension QuestionResultQuerySortBy
    on QueryBuilder<QuestionResult, QuestionResult, QSortBy> {
  QueryBuilder<QuestionResult, QuestionResult, QAfterSortBy> sortByIsCorrect() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCorrect', Sort.asc);
    });
  }

  QueryBuilder<QuestionResult, QuestionResult, QAfterSortBy>
      sortByIsCorrectDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCorrect', Sort.desc);
    });
  }

  QueryBuilder<QuestionResult, QuestionResult, QAfterSortBy>
      sortByQuestionIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionIndex', Sort.asc);
    });
  }

  QueryBuilder<QuestionResult, QuestionResult, QAfterSortBy>
      sortByQuestionIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionIndex', Sort.desc);
    });
  }

  QueryBuilder<QuestionResult, QuestionResult, QAfterSortBy>
      sortByTotalSolvingTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSolvingTime', Sort.asc);
    });
  }

  QueryBuilder<QuestionResult, QuestionResult, QAfterSortBy>
      sortByTotalSolvingTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSolvingTime', Sort.desc);
    });
  }
}

extension QuestionResultQuerySortThenBy
    on QueryBuilder<QuestionResult, QuestionResult, QSortThenBy> {
  QueryBuilder<QuestionResult, QuestionResult, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<QuestionResult, QuestionResult, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<QuestionResult, QuestionResult, QAfterSortBy> thenByIsCorrect() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCorrect', Sort.asc);
    });
  }

  QueryBuilder<QuestionResult, QuestionResult, QAfterSortBy>
      thenByIsCorrectDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCorrect', Sort.desc);
    });
  }

  QueryBuilder<QuestionResult, QuestionResult, QAfterSortBy>
      thenByQuestionIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionIndex', Sort.asc);
    });
  }

  QueryBuilder<QuestionResult, QuestionResult, QAfterSortBy>
      thenByQuestionIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionIndex', Sort.desc);
    });
  }

  QueryBuilder<QuestionResult, QuestionResult, QAfterSortBy>
      thenByTotalSolvingTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSolvingTime', Sort.asc);
    });
  }

  QueryBuilder<QuestionResult, QuestionResult, QAfterSortBy>
      thenByTotalSolvingTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSolvingTime', Sort.desc);
    });
  }
}

extension QuestionResultQueryWhereDistinct
    on QueryBuilder<QuestionResult, QuestionResult, QDistinct> {
  QueryBuilder<QuestionResult, QuestionResult, QDistinct>
      distinctByIsCorrect() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCorrect');
    });
  }

  QueryBuilder<QuestionResult, QuestionResult, QDistinct>
      distinctByQuestionIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'questionIndex');
    });
  }

  QueryBuilder<QuestionResult, QuestionResult, QDistinct>
      distinctByTotalSolvingTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalSolvingTime');
    });
  }
}

extension QuestionResultQueryProperty
    on QueryBuilder<QuestionResult, QuestionResult, QQueryProperty> {
  QueryBuilder<QuestionResult, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<QuestionResult, bool?, QQueryOperations> isCorrectProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCorrect');
    });
  }

  QueryBuilder<QuestionResult, int, QQueryOperations> questionIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'questionIndex');
    });
  }

  QueryBuilder<QuestionResult, double, QQueryOperations>
      totalSolvingTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalSolvingTime');
    });
  }
}
