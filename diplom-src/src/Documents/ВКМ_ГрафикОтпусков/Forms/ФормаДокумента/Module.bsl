#Область ОбработчикиСобытийФормы
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	УстановитьУсловноеОформление();
КонецПроцедуры
#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыОтпускаСотрудников
&НаКлиенте
Процедура ОтпускаСотрудниковПриИзменении(Элемент)
	ОтпускаСотрудниковПриИзмененииНаСервере();
КонецПроцедуры
#КонецОбласти

#Область ОбработчикиКомандФормы
&НаКлиенте
Процедура ОткрытьАнализГрафика(Команда)
	
	Адрес = ПолучитьДанныеДляДиограммы();
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("АдресХранилища", Адрес); 
	
	ОткрытьФорму("Документ.ВКМ_ГрафикОтпусков.Форма.АнализГрафика", ПараметрыФормы, ЭтотОбъект,,,,,РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры
#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ОтпускаСотрудниковПриИзмененииНаСервере()
	УстановитьУсловноеОформление();
	ЭтотОбъект.Записать();
	Элементы.ОтпускаСотрудников.Обновить();
КонецПроцедуры

&НаСервере
Процедура УстановитьУсловноеОформление() 
	
	Если Объект.ОтпускаСотрудников.Количество() = 0 Тогда
		ОбщегоНазначения.СообщитьПользователю("Не заполнена табличная часть документа",,"ОтпускаСотрудников","Объект.ОтпускаСотрудников");
		Возврат;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	ВКМ_ГрафикОтпусковОтпускаСотрудников.Сотрудник КАК Сотрудник,
	               |	СУММА(РАЗНОСТЬДАТ(ВКМ_ГрафикОтпусковОтпускаСотрудников.ДатаНачала, ВКМ_ГрафикОтпусковОтпускаСотрудников.ДатаОкончания, ДЕНЬ)) КАК ДнейОтпуска
	               |ПОМЕСТИТЬ ДТ_ДанныеДокумента
	               |ИЗ
	               |	Документ.ВКМ_ГрафикОтпусков.ОтпускаСотрудников КАК ВКМ_ГрафикОтпусковОтпускаСотрудников
	               |ГДЕ
	               |	ВКМ_ГрафикОтпусковОтпускаСотрудников.Ссылка = &Ссылка
	               |
	               |СГРУППИРОВАТЬ ПО
	               |	ВКМ_ГрафикОтпусковОтпускаСотрудников.Сотрудник
	               |;
	               |
	               |////////////////////////////////////////////////////////////////////////////////
	               |ВЫБРАТЬ
	               |	ДТ_ДанныеДокумента.Сотрудник КАК Сотрудник,
	               |	ДТ_ДанныеДокумента.ДнейОтпуска КАК ДнейОтпуска
	               |ИЗ
	               |	ДТ_ДанныеДокумента КАК ДТ_ДанныеДокумента
	               |ГДЕ
	               |	ДТ_ДанныеДокумента.ДнейОтпуска > 28";
	
	Запрос.УстановитьПараметр("Ссылка", Объект.Ссылка);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	ДанныеОтбора = Новый Структура();
	
	Пока Выборка.Следующий() Цикл 
		
		ДанныеОтбора.Вставить("Сотрудник", Выборка.Сотрудник); 
		
		ЭлементУсловногоОформления = УсловноеОформление.Элементы.Добавить();
		ОформляемоеПоле = ЭлементУсловногоОформления.Поля.Элементы.Добавить();
		ОформляемоеПоле.Поле = Новый ПолеКомпоновкиДанных(Элементы.ОтпускаСотрудников.Имя);
		
		ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(ЭлементУсловногоОформления.Отбор,
		"Объект.ОтпускаСотрудников.Сотрудник", ВидСравненияКомпоновкиДанных.Равно,ДанныеОтбора.Сотрудник);
		ЭлементУсловногоОформления.Оформление.УстановитьЗначениеПараметра("ЦветФона", WebЦвета.СеребристоСерый); 
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Функция ПолучитьДанныеДляДиограммы()
	
	ДанныеДокумента = Объект.ОтпускаСотрудников.Выгрузить();
	
	Возврат ПоместитьВоВременноеХранилище(ДанныеДокумента, Новый УникальныйИдентификатор);
	
КонецФункции

#КонецОбласти
