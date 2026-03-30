// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _barcodeMeta = const VerificationMeta(
    'barcode',
  );
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
    'barcode',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _expiryDateMeta = const VerificationMeta(
    'expiryDate',
  );
  @override
  late final GeneratedColumn<DateTime> expiryDate = GeneratedColumn<DateTime>(
    'expiry_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addedDateMeta = const VerificationMeta(
    'addedDate',
  );
  @override
  late final GeneratedColumn<DateTime> addedDate = GeneratedColumn<DateTime>(
    'added_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isConsumedMeta = const VerificationMeta(
    'isConsumed',
  );
  @override
  late final GeneratedColumn<bool> isConsumed = GeneratedColumn<bool>(
    'is_consumed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_consumed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    category,
    barcode,
    expiryDate,
    addedDate,
    isConsumed,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(
    Insertable<Product> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('barcode')) {
      context.handle(
        _barcodeMeta,
        barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta),
      );
    }
    if (data.containsKey('expiry_date')) {
      context.handle(
        _expiryDateMeta,
        expiryDate.isAcceptableOrUnknown(data['expiry_date']!, _expiryDateMeta),
      );
    }
    if (data.containsKey('added_date')) {
      context.handle(
        _addedDateMeta,
        addedDate.isAcceptableOrUnknown(data['added_date']!, _addedDateMeta),
      );
    } else if (isInserting) {
      context.missing(_addedDateMeta);
    }
    if (data.containsKey('is_consumed')) {
      context.handle(
        _isConsumedMeta,
        isConsumed.isAcceptableOrUnknown(data['is_consumed']!, _isConsumedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Product map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Product(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      barcode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}barcode'],
      ),
      expiryDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expiry_date'],
      ),
      addedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}added_date'],
      )!,
      isConsumed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_consumed'],
      )!,
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class Product extends DataClass implements Insertable<Product> {
  final int id;
  final String name;
  final String category;
  final String? barcode;
  final DateTime? expiryDate;
  final DateTime addedDate;
  final bool isConsumed;
  const Product({
    required this.id,
    required this.name,
    required this.category,
    this.barcode,
    this.expiryDate,
    required this.addedDate,
    required this.isConsumed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || barcode != null) {
      map['barcode'] = Variable<String>(barcode);
    }
    if (!nullToAbsent || expiryDate != null) {
      map['expiry_date'] = Variable<DateTime>(expiryDate);
    }
    map['added_date'] = Variable<DateTime>(addedDate);
    map['is_consumed'] = Variable<bool>(isConsumed);
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      name: Value(name),
      category: Value(category),
      barcode: barcode == null && nullToAbsent
          ? const Value.absent()
          : Value(barcode),
      expiryDate: expiryDate == null && nullToAbsent
          ? const Value.absent()
          : Value(expiryDate),
      addedDate: Value(addedDate),
      isConsumed: Value(isConsumed),
    );
  }

  factory Product.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Product(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      barcode: serializer.fromJson<String?>(json['barcode']),
      expiryDate: serializer.fromJson<DateTime?>(json['expiryDate']),
      addedDate: serializer.fromJson<DateTime>(json['addedDate']),
      isConsumed: serializer.fromJson<bool>(json['isConsumed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'barcode': serializer.toJson<String?>(barcode),
      'expiryDate': serializer.toJson<DateTime?>(expiryDate),
      'addedDate': serializer.toJson<DateTime>(addedDate),
      'isConsumed': serializer.toJson<bool>(isConsumed),
    };
  }

  Product copyWith({
    int? id,
    String? name,
    String? category,
    Value<String?> barcode = const Value.absent(),
    Value<DateTime?> expiryDate = const Value.absent(),
    DateTime? addedDate,
    bool? isConsumed,
  }) => Product(
    id: id ?? this.id,
    name: name ?? this.name,
    category: category ?? this.category,
    barcode: barcode.present ? barcode.value : this.barcode,
    expiryDate: expiryDate.present ? expiryDate.value : this.expiryDate,
    addedDate: addedDate ?? this.addedDate,
    isConsumed: isConsumed ?? this.isConsumed,
  );
  Product copyWithCompanion(ProductsCompanion data) {
    return Product(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      expiryDate: data.expiryDate.present
          ? data.expiryDate.value
          : this.expiryDate,
      addedDate: data.addedDate.present ? data.addedDate.value : this.addedDate,
      isConsumed: data.isConsumed.present
          ? data.isConsumed.value
          : this.isConsumed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('barcode: $barcode, ')
          ..write('expiryDate: $expiryDate, ')
          ..write('addedDate: $addedDate, ')
          ..write('isConsumed: $isConsumed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    category,
    barcode,
    expiryDate,
    addedDate,
    isConsumed,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          other.id == this.id &&
          other.name == this.name &&
          other.category == this.category &&
          other.barcode == this.barcode &&
          other.expiryDate == this.expiryDate &&
          other.addedDate == this.addedDate &&
          other.isConsumed == this.isConsumed);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> category;
  final Value<String?> barcode;
  final Value<DateTime?> expiryDate;
  final Value<DateTime> addedDate;
  final Value<bool> isConsumed;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.barcode = const Value.absent(),
    this.expiryDate = const Value.absent(),
    this.addedDate = const Value.absent(),
    this.isConsumed = const Value.absent(),
  });
  ProductsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String category,
    this.barcode = const Value.absent(),
    this.expiryDate = const Value.absent(),
    required DateTime addedDate,
    this.isConsumed = const Value.absent(),
  }) : name = Value(name),
       category = Value(category),
       addedDate = Value(addedDate);
  static Insertable<Product> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? category,
    Expression<String>? barcode,
    Expression<DateTime>? expiryDate,
    Expression<DateTime>? addedDate,
    Expression<bool>? isConsumed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (barcode != null) 'barcode': barcode,
      if (expiryDate != null) 'expiry_date': expiryDate,
      if (addedDate != null) 'added_date': addedDate,
      if (isConsumed != null) 'is_consumed': isConsumed,
    });
  }

  ProductsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? category,
    Value<String?>? barcode,
    Value<DateTime?>? expiryDate,
    Value<DateTime>? addedDate,
    Value<bool>? isConsumed,
  }) {
    return ProductsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      barcode: barcode ?? this.barcode,
      expiryDate: expiryDate ?? this.expiryDate,
      addedDate: addedDate ?? this.addedDate,
      isConsumed: isConsumed ?? this.isConsumed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    if (expiryDate.present) {
      map['expiry_date'] = Variable<DateTime>(expiryDate.value);
    }
    if (addedDate.present) {
      map['added_date'] = Variable<DateTime>(addedDate.value);
    }
    if (isConsumed.present) {
      map['is_consumed'] = Variable<bool>(isConsumed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('barcode: $barcode, ')
          ..write('expiryDate: $expiryDate, ')
          ..write('addedDate: $addedDate, ')
          ..write('isConsumed: $isConsumed')
          ..write(')'))
        .toString();
  }
}

class $WasteEventsTable extends WasteEvents
    with TableInfo<$WasteEventsTable, WasteEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WasteEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _productNameMeta = const VerificationMeta(
    'productName',
  );
  @override
  late final GeneratedColumn<String> productName = GeneratedColumn<String>(
    'product_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<String> quantity = GeneratedColumn<String>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('tout'),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productName,
    category,
    reason,
    quantity,
    date,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'waste_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<WasteEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_name')) {
      context.handle(
        _productNameMeta,
        productName.isAcceptableOrUnknown(
          data['product_name']!,
          _productNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_productNameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    } else if (isInserting) {
      context.missing(_reasonMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WasteEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WasteEvent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      productName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quantity'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
    );
  }

  @override
  $WasteEventsTable createAlias(String alias) {
    return $WasteEventsTable(attachedDatabase, alias);
  }
}

class WasteEvent extends DataClass implements Insertable<WasteEvent> {
  final int id;
  final String productName;
  final String category;
  final String reason;
  final String quantity;
  final DateTime date;
  const WasteEvent({
    required this.id,
    required this.productName,
    required this.category,
    required this.reason,
    required this.quantity,
    required this.date,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_name'] = Variable<String>(productName);
    map['category'] = Variable<String>(category);
    map['reason'] = Variable<String>(reason);
    map['quantity'] = Variable<String>(quantity);
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  WasteEventsCompanion toCompanion(bool nullToAbsent) {
    return WasteEventsCompanion(
      id: Value(id),
      productName: Value(productName),
      category: Value(category),
      reason: Value(reason),
      quantity: Value(quantity),
      date: Value(date),
    );
  }

  factory WasteEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WasteEvent(
      id: serializer.fromJson<int>(json['id']),
      productName: serializer.fromJson<String>(json['productName']),
      category: serializer.fromJson<String>(json['category']),
      reason: serializer.fromJson<String>(json['reason']),
      quantity: serializer.fromJson<String>(json['quantity']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productName': serializer.toJson<String>(productName),
      'category': serializer.toJson<String>(category),
      'reason': serializer.toJson<String>(reason),
      'quantity': serializer.toJson<String>(quantity),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  WasteEvent copyWith({
    int? id,
    String? productName,
    String? category,
    String? reason,
    String? quantity,
    DateTime? date,
  }) => WasteEvent(
    id: id ?? this.id,
    productName: productName ?? this.productName,
    category: category ?? this.category,
    reason: reason ?? this.reason,
    quantity: quantity ?? this.quantity,
    date: date ?? this.date,
  );
  WasteEvent copyWithCompanion(WasteEventsCompanion data) {
    return WasteEvent(
      id: data.id.present ? data.id.value : this.id,
      productName: data.productName.present
          ? data.productName.value
          : this.productName,
      category: data.category.present ? data.category.value : this.category,
      reason: data.reason.present ? data.reason.value : this.reason,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      date: data.date.present ? data.date.value : this.date,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WasteEvent(')
          ..write('id: $id, ')
          ..write('productName: $productName, ')
          ..write('category: $category, ')
          ..write('reason: $reason, ')
          ..write('quantity: $quantity, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, productName, category, reason, quantity, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WasteEvent &&
          other.id == this.id &&
          other.productName == this.productName &&
          other.category == this.category &&
          other.reason == this.reason &&
          other.quantity == this.quantity &&
          other.date == this.date);
}

class WasteEventsCompanion extends UpdateCompanion<WasteEvent> {
  final Value<int> id;
  final Value<String> productName;
  final Value<String> category;
  final Value<String> reason;
  final Value<String> quantity;
  final Value<DateTime> date;
  const WasteEventsCompanion({
    this.id = const Value.absent(),
    this.productName = const Value.absent(),
    this.category = const Value.absent(),
    this.reason = const Value.absent(),
    this.quantity = const Value.absent(),
    this.date = const Value.absent(),
  });
  WasteEventsCompanion.insert({
    this.id = const Value.absent(),
    required String productName,
    required String category,
    required String reason,
    this.quantity = const Value.absent(),
    required DateTime date,
  }) : productName = Value(productName),
       category = Value(category),
       reason = Value(reason),
       date = Value(date);
  static Insertable<WasteEvent> custom({
    Expression<int>? id,
    Expression<String>? productName,
    Expression<String>? category,
    Expression<String>? reason,
    Expression<String>? quantity,
    Expression<DateTime>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productName != null) 'product_name': productName,
      if (category != null) 'category': category,
      if (reason != null) 'reason': reason,
      if (quantity != null) 'quantity': quantity,
      if (date != null) 'date': date,
    });
  }

  WasteEventsCompanion copyWith({
    Value<int>? id,
    Value<String>? productName,
    Value<String>? category,
    Value<String>? reason,
    Value<String>? quantity,
    Value<DateTime>? date,
  }) {
    return WasteEventsCompanion(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      category: category ?? this.category,
      reason: reason ?? this.reason,
      quantity: quantity ?? this.quantity,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<String>(quantity.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WasteEventsCompanion(')
          ..write('id: $id, ')
          ..write('productName: $productName, ')
          ..write('category: $category, ')
          ..write('reason: $reason, ')
          ..write('quantity: $quantity, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $WasteEventsTable wasteEvents = $WasteEventsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [products, wasteEvents];
}

typedef $$ProductsTableCreateCompanionBuilder =
    ProductsCompanion Function({
      Value<int> id,
      required String name,
      required String category,
      Value<String?> barcode,
      Value<DateTime?> expiryDate,
      required DateTime addedDate,
      Value<bool> isConsumed,
    });
typedef $$ProductsTableUpdateCompanionBuilder =
    ProductsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> category,
      Value<String?> barcode,
      Value<DateTime?> expiryDate,
      Value<DateTime> addedDate,
      Value<bool> isConsumed,
    });

class $$ProductsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expiryDate => $composableBuilder(
    column: $table.expiryDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get addedDate => $composableBuilder(
    column: $table.addedDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isConsumed => $composableBuilder(
    column: $table.isConsumed,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expiryDate => $composableBuilder(
    column: $table.expiryDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get addedDate => $composableBuilder(
    column: $table.addedDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isConsumed => $composableBuilder(
    column: $table.isConsumed,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => column);

  GeneratedColumn<DateTime> get expiryDate => $composableBuilder(
    column: $table.expiryDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get addedDate =>
      $composableBuilder(column: $table.addedDate, builder: (column) => column);

  GeneratedColumn<bool> get isConsumed => $composableBuilder(
    column: $table.isConsumed,
    builder: (column) => column,
  );
}

class $$ProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductsTable,
          Product,
          $$ProductsTableFilterComposer,
          $$ProductsTableOrderingComposer,
          $$ProductsTableAnnotationComposer,
          $$ProductsTableCreateCompanionBuilder,
          $$ProductsTableUpdateCompanionBuilder,
          (Product, BaseReferences<_$AppDatabase, $ProductsTable, Product>),
          Product,
          PrefetchHooks Function()
        > {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                Value<DateTime?> expiryDate = const Value.absent(),
                Value<DateTime> addedDate = const Value.absent(),
                Value<bool> isConsumed = const Value.absent(),
              }) => ProductsCompanion(
                id: id,
                name: name,
                category: category,
                barcode: barcode,
                expiryDate: expiryDate,
                addedDate: addedDate,
                isConsumed: isConsumed,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String category,
                Value<String?> barcode = const Value.absent(),
                Value<DateTime?> expiryDate = const Value.absent(),
                required DateTime addedDate,
                Value<bool> isConsumed = const Value.absent(),
              }) => ProductsCompanion.insert(
                id: id,
                name: name,
                category: category,
                barcode: barcode,
                expiryDate: expiryDate,
                addedDate: addedDate,
                isConsumed: isConsumed,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductsTable,
      Product,
      $$ProductsTableFilterComposer,
      $$ProductsTableOrderingComposer,
      $$ProductsTableAnnotationComposer,
      $$ProductsTableCreateCompanionBuilder,
      $$ProductsTableUpdateCompanionBuilder,
      (Product, BaseReferences<_$AppDatabase, $ProductsTable, Product>),
      Product,
      PrefetchHooks Function()
    >;
typedef $$WasteEventsTableCreateCompanionBuilder =
    WasteEventsCompanion Function({
      Value<int> id,
      required String productName,
      required String category,
      required String reason,
      Value<String> quantity,
      required DateTime date,
    });
typedef $$WasteEventsTableUpdateCompanionBuilder =
    WasteEventsCompanion Function({
      Value<int> id,
      Value<String> productName,
      Value<String> category,
      Value<String> reason,
      Value<String> quantity,
      Value<DateTime> date,
    });

class $$WasteEventsTableFilterComposer
    extends Composer<_$AppDatabase, $WasteEventsTable> {
  $$WasteEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WasteEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $WasteEventsTable> {
  $$WasteEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WasteEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WasteEventsTable> {
  $$WasteEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);
}

class $$WasteEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WasteEventsTable,
          WasteEvent,
          $$WasteEventsTableFilterComposer,
          $$WasteEventsTableOrderingComposer,
          $$WasteEventsTableAnnotationComposer,
          $$WasteEventsTableCreateCompanionBuilder,
          $$WasteEventsTableUpdateCompanionBuilder,
          (
            WasteEvent,
            BaseReferences<_$AppDatabase, $WasteEventsTable, WasteEvent>,
          ),
          WasteEvent,
          PrefetchHooks Function()
        > {
  $$WasteEventsTableTableManager(_$AppDatabase db, $WasteEventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WasteEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WasteEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WasteEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> productName = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> reason = const Value.absent(),
                Value<String> quantity = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
              }) => WasteEventsCompanion(
                id: id,
                productName: productName,
                category: category,
                reason: reason,
                quantity: quantity,
                date: date,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String productName,
                required String category,
                required String reason,
                Value<String> quantity = const Value.absent(),
                required DateTime date,
              }) => WasteEventsCompanion.insert(
                id: id,
                productName: productName,
                category: category,
                reason: reason,
                quantity: quantity,
                date: date,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WasteEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WasteEventsTable,
      WasteEvent,
      $$WasteEventsTableFilterComposer,
      $$WasteEventsTableOrderingComposer,
      $$WasteEventsTableAnnotationComposer,
      $$WasteEventsTableCreateCompanionBuilder,
      $$WasteEventsTableUpdateCompanionBuilder,
      (
        WasteEvent,
        BaseReferences<_$AppDatabase, $WasteEventsTable, WasteEvent>,
      ),
      WasteEvent,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$WasteEventsTableTableManager get wasteEvents =>
      $$WasteEventsTableTableManager(_db, _db.wasteEvents);
}
