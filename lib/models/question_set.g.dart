// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_set.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetQuestionSetCollection on Isar {
  IsarCollection<QuestionSet> get questionSets => this.collection();
}

const QuestionSetSchema = CollectionSchema(
  name: r'QuestionSet',
  id: 5302932601000217119,
  properties: {
    r'expectedTotalTime': PropertySchema(
      id: 0,
      name: r'expectedTotalTime',
      type: IsarType.double,
    ),
    r'questionCount': PropertySchema(
      id: 1,
      name: r'questionCount',
      type: IsarType.long,
    ),
    r'questionMetadatas': PropertySchema(
      id: 2,
      name: r'questionMetadatas',
      type: IsarType.objectList,
      target: r'QuestionMetadata',
    ),
    r'title': PropertySchema(
      id: 3,
      name: r'title',
      type: IsarType.string,
    )
  },
  estimateSize: _questionSetEstimateSize,
  serialize: _questionSetSerialize,
  deserialize: _questionSetDeserialize,
  deserializeProp: _questionSetDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'sessions': LinkSchema(
      id: -4227162996182871642,
      name: r'sessions',
      target: r'Session',
      single: false,
      linkName: r'questionSet',
    )
  },
  embeddedSchemas: {r'QuestionMetadata': QuestionMetadataSchema},
  getId: _questionSetGetId,
  getLinks: _questionSetGetLinks,
  attach: _questionSetAttach,
  version: '3.1.0+1',
);

int _questionSetEstimateSize(
  QuestionSet object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.questionMetadatas;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[QuestionMetadata]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              QuestionMetadataSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _questionSetSerialize(
  QuestionSet object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.expectedTotalTime);
  writer.writeLong(offsets[1], object.questionCount);
  writer.writeObjectList<QuestionMetadata>(
    offsets[2],
    allOffsets,
    QuestionMetadataSchema.serialize,
    object.questionMetadatas,
  );
  writer.writeString(offsets[3], object.title);
}

QuestionSet _questionSetDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = QuestionSet();
  object.expectedTotalTime = reader.readDoubleOrNull(offsets[0]);
  object.id = id;
  object.questionCount = reader.readLong(offsets[1]);
  object.questionMetadatas = reader.readObjectList<QuestionMetadata>(
    offsets[2],
    QuestionMetadataSchema.deserialize,
    allOffsets,
    QuestionMetadata(),
  );
  object.title = reader.readString(offsets[3]);
  return object;
}

P _questionSetDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readObjectList<QuestionMetadata>(
        offset,
        QuestionMetadataSchema.deserialize,
        allOffsets,
        QuestionMetadata(),
      )) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _questionSetGetId(QuestionSet object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _questionSetGetLinks(QuestionSet object) {
  return [object.sessions];
}

void _questionSetAttach(
    IsarCollection<dynamic> col, Id id, QuestionSet object) {
  object.id = id;
  object.sessions.attach(col, col.isar.collection<Session>(), r'sessions', id);
}

extension QuestionSetQueryWhereSort
    on QueryBuilder<QuestionSet, QuestionSet, QWhere> {
  QueryBuilder<QuestionSet, QuestionSet, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension QuestionSetQueryWhere
    on QueryBuilder<QuestionSet, QuestionSet, QWhereClause> {
  QueryBuilder<QuestionSet, QuestionSet, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<QuestionSet, QuestionSet, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterWhereClause> idBetween(
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

extension QuestionSetQueryFilter
    on QueryBuilder<QuestionSet, QuestionSet, QFilterCondition> {
  QueryBuilder<QuestionSet, QuestionSet, QAfterFilterCondition>
      expectedTotalTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'expectedTotalTime',
      ));
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterFilterCondition>
      expectedTotalTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'expectedTotalTime',
      ));
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterFilterCondition>
      expectedTotalTimeEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expectedTotalTime',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterFilterCondition>
      expectedTotalTimeGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expectedTotalTime',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterFilterCondition>
      expectedTotalTimeLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expectedTotalTime',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterFilterCondition>
      expectedTotalTimeBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expectedTotalTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<QuestionSet, QuestionSet, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<QuestionSet, QuestionSet, QAfterFilterCondition> idBetween(
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

  QueryBuilder<QuestionSet, QuestionSet, QAfterFilterCondition>
      questionCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'questionCount',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterFilterCondition>
      questionCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'questionCount',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterFilterCondition>
      questionCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'questionCount',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterFilterCondition>
      questionCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'questionCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterFilterCondition>
      questionMetadatasIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'questionMetadatas',
      ));
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterFilterCondition>
      questionMetadatasIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'questionMetadatas',
      ));
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterFilterCondition>
      questionMetadatasLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'questionMetadatas',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterFilterCondition>
      questionMetadatasIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'questionMetadatas',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterFilterCondition>
      questionMetadatasIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'questionMetadatas',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterFilterCondition>
      questionMetadatasLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'questionMetadatas',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterFilterCondition>
      questionMetadatasLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'questionMetadatas',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterFilterCondition>
      questionMetadatasLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'questionMetadatas',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterFilterCondition>
      titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterFilterCondition> titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }
}

extension QuestionSetQueryObject
    on QueryBuilder<QuestionSet, QuestionSet, QFilterCondition> {
  QueryBuilder<QuestionSet, QuestionSet, QAfterFilterCondition>
      questionMetadatasElement(FilterQuery<QuestionMetadata> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'questionMetadatas');
    });
  }
}

extension QuestionSetQueryLinks
    on QueryBuilder<QuestionSet, QuestionSet, QFilterCondition> {
  QueryBuilder<QuestionSet, QuestionSet, QAfterFilterCondition> sessions(
      FilterQuery<Session> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'sessions');
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterFilterCondition>
      sessionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'sessions', length, true, length, true);
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterFilterCondition>
      sessionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'sessions', 0, true, 0, true);
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterFilterCondition>
      sessionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'sessions', 0, false, 999999, true);
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterFilterCondition>
      sessionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'sessions', 0, true, length, include);
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterFilterCondition>
      sessionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'sessions', length, include, 999999, true);
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterFilterCondition>
      sessionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'sessions', lower, includeLower, upper, includeUpper);
    });
  }
}

extension QuestionSetQuerySortBy
    on QueryBuilder<QuestionSet, QuestionSet, QSortBy> {
  QueryBuilder<QuestionSet, QuestionSet, QAfterSortBy>
      sortByExpectedTotalTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedTotalTime', Sort.asc);
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterSortBy>
      sortByExpectedTotalTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedTotalTime', Sort.desc);
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterSortBy> sortByQuestionCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionCount', Sort.asc);
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterSortBy>
      sortByQuestionCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionCount', Sort.desc);
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension QuestionSetQuerySortThenBy
    on QueryBuilder<QuestionSet, QuestionSet, QSortThenBy> {
  QueryBuilder<QuestionSet, QuestionSet, QAfterSortBy>
      thenByExpectedTotalTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedTotalTime', Sort.asc);
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterSortBy>
      thenByExpectedTotalTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedTotalTime', Sort.desc);
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterSortBy> thenByQuestionCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionCount', Sort.asc);
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterSortBy>
      thenByQuestionCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionCount', Sort.desc);
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension QuestionSetQueryWhereDistinct
    on QueryBuilder<QuestionSet, QuestionSet, QDistinct> {
  QueryBuilder<QuestionSet, QuestionSet, QDistinct>
      distinctByExpectedTotalTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expectedTotalTime');
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QDistinct> distinctByQuestionCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'questionCount');
    });
  }

  QueryBuilder<QuestionSet, QuestionSet, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }
}

extension QuestionSetQueryProperty
    on QueryBuilder<QuestionSet, QuestionSet, QQueryProperty> {
  QueryBuilder<QuestionSet, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<QuestionSet, double?, QQueryOperations>
      expectedTotalTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expectedTotalTime');
    });
  }

  QueryBuilder<QuestionSet, int, QQueryOperations> questionCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'questionCount');
    });
  }

  QueryBuilder<QuestionSet, List<QuestionMetadata>?, QQueryOperations>
      questionMetadatasProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'questionMetadatas');
    });
  }

  QueryBuilder<QuestionSet, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const QuestionMetadataSchema = Schema(
  name: r'QuestionMetadata',
  id: 3883085743693180168,
  properties: {
    r'difficulty': PropertySchema(
      id: 0,
      name: r'difficulty',
      type: IsarType.string,
    ),
    r'expectedTime': PropertySchema(
      id: 1,
      name: r'expectedTime',
      type: IsarType.double,
    ),
    r'extraData': PropertySchema(
      id: 2,
      name: r'extraData',
      type: IsarType.stringList,
    ),
    r'index': PropertySchema(
      id: 3,
      name: r'index',
      type: IsarType.long,
    ),
    r'questionType': PropertySchema(
      id: 4,
      name: r'questionType',
      type: IsarType.string,
    )
  },
  estimateSize: _questionMetadataEstimateSize,
  serialize: _questionMetadataSerialize,
  deserialize: _questionMetadataDeserialize,
  deserializeProp: _questionMetadataDeserializeProp,
);

int _questionMetadataEstimateSize(
  QuestionMetadata object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.difficulty;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.extraData;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  {
    final value = object.questionType;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _questionMetadataSerialize(
  QuestionMetadata object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.difficulty);
  writer.writeDouble(offsets[1], object.expectedTime);
  writer.writeStringList(offsets[2], object.extraData);
  writer.writeLong(offsets[3], object.index);
  writer.writeString(offsets[4], object.questionType);
}

QuestionMetadata _questionMetadataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = QuestionMetadata();
  object.difficulty = reader.readStringOrNull(offsets[0]);
  object.expectedTime = reader.readDoubleOrNull(offsets[1]);
  object.extraData = reader.readStringList(offsets[2]);
  object.index = reader.readLongOrNull(offsets[3]);
  object.questionType = reader.readStringOrNull(offsets[4]);
  return object;
}

P _questionMetadataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readDoubleOrNull(offset)) as P;
    case 2:
      return (reader.readStringList(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension QuestionMetadataQueryFilter
    on QueryBuilder<QuestionMetadata, QuestionMetadata, QFilterCondition> {
  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      difficultyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'difficulty',
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      difficultyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'difficulty',
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      difficultyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'difficulty',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      difficultyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'difficulty',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      difficultyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'difficulty',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      difficultyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'difficulty',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      difficultyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'difficulty',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      difficultyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'difficulty',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      difficultyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'difficulty',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      difficultyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'difficulty',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      difficultyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'difficulty',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      difficultyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'difficulty',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      expectedTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'expectedTime',
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      expectedTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'expectedTime',
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      expectedTimeEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expectedTime',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      expectedTimeGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expectedTime',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      expectedTimeLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expectedTime',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      expectedTimeBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expectedTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      extraDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'extraData',
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      extraDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'extraData',
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      extraDataElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'extraData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      extraDataElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'extraData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      extraDataElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'extraData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      extraDataElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'extraData',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      extraDataElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'extraData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      extraDataElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'extraData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      extraDataElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'extraData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      extraDataElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'extraData',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      extraDataElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'extraData',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      extraDataElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'extraData',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      extraDataLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'extraData',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      extraDataIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'extraData',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      extraDataIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'extraData',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      extraDataLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'extraData',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      extraDataLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'extraData',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      extraDataLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'extraData',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      indexIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'index',
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      indexIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'index',
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      indexEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'index',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      indexGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'index',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      indexLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'index',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      indexBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'index',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      questionTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'questionType',
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      questionTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'questionType',
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      questionTypeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'questionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      questionTypeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'questionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      questionTypeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'questionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      questionTypeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'questionType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      questionTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'questionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      questionTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'questionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      questionTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'questionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      questionTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'questionType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      questionTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'questionType',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionMetadata, QuestionMetadata, QAfterFilterCondition>
      questionTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'questionType',
        value: '',
      ));
    });
  }
}

extension QuestionMetadataQueryObject
    on QueryBuilder<QuestionMetadata, QuestionMetadata, QFilterCondition> {}
