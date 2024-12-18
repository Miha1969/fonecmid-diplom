
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	
	Ответственный = Пользователи.ТекущийПользователь();
	
	Если ТипЗнч(ДанныеЗаполнения) = Тип("ДокументСсылка.ЗаказПокупателя") Тогда
		ЗаполнитьНаОснованииЗаказаПокупателя(ДанныеЗаполнения);
	КонецЕсли;
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;

	СуммаДокумента = Товары.Итог("Сумма") + Услуги.Итог("Сумма");
	
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, Режим)
	
	Движения.ОбработкаЗаказов.Записывать = Истина;
	Движения.ОстаткиТоваров.Записывать = Истина;
	// {{ Алексеев М.Д. Добавлено возможность записи в новый регистр 
	//Документ установлен как регистратор для регистра Продажи
	Движения.Продажи.Записывать = Истина;
	//}}
	
	Движение = Движения.ОбработкаЗаказов.Добавить();
	Движение.Период = Дата;
	Движение.Контрагент = Контрагент;
	Движение.Договор = Договор;
	Движение.Заказ = Основание;
	Движение.СуммаОтгрузки = СуммаДокумента;
	
	Для Каждого ТекСтрокаТовары Из Товары Цикл
		// {{ Алексеев М.Д. Добавлено условие для записи номомклатуры вид "Услуга" 
		//Движение = Движения.ОстаткиТоваров.Добавить();
		//Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
		//Движение.Период = Дата;
		//Движение.Контрагент = Контрагент;
		//Движение.Номенклатура = ТекСтрокаТовары.Номенклатура;
		//Движение.Сумма = ТекСтрокаТовары.Сумма;
		//Движение.Количество = ТекСтрокаТовары.Количество;
		ЗначенияРеквизитов = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(ТекСтрокаТовары.Номенклатура, "ВидНоменклатуры");
		Если  ЗначенияРеквизитов.ВидНоменклатуры <> Перечисления.ВидыНоменклатуры.Услуга Тогда	
			Движение = Движения.ОстаткиТоваров.Добавить();
			Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
			Движение.Период = Дата;
			Движение.Контрагент = Контрагент;
			Движение.Номенклатура = ТекСтрокаТовары.Номенклатура;
			Движение.Сумма = ТекСтрокаТовары.Сумма;
			Движение.Количество = ТекСтрокаТовары.Количество;
		КонецЕсли;
		Движение = Движения.Продажи.Добавить();
		Движение.Период = Дата;
		Движение.Контрагент = Контрагент;
		Движение.Номенклатура = ТекСтрокаТовары.Номенклатура;
		Движение.Сумма = ТекСтрокаТовары.Сумма;
		//}}
	КонецЦикла;
	// {{ Алексеев М.Д.: Вызов метода "ПроверитьЗаполнение()"
	ПроверитьЗаполнение();
	//}}
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ЗаполнитьНаОснованииЗаказаПокупателя(ДанныеЗаполнения)
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	ЗаказПокупателя.Организация КАК Организация,
	               |	ЗаказПокупателя.Контрагент КАК Контрагент,
	               |	ЗаказПокупателя.Договор КАК Договор,
	               |	ЗаказПокупателя.СуммаДокумента КАК СуммаДокумента,
	               |	ЗаказПокупателя.Товары.(
	               |		Ссылка КАК Ссылка,
	               |		НомерСтроки КАК НомерСтроки,
	               |		Номенклатура КАК Номенклатура,
	               |		Количество КАК Количество,
	               |		Цена КАК Цена,
	               |		Сумма КАК Сумма
	               |	) КАК Товары,
	               |	ЗаказПокупателя.Услуги.(
	               |		Ссылка КАК Ссылка,
	               |		НомерСтроки КАК НомерСтроки,
	               |		Номенклатура КАК Номенклатура,
	               |		Количество КАК Количество,
	               |		Цена КАК Цена,
	               |		Сумма КАК Сумма
	               |	) КАК Услуги
	               |ИЗ
	               |	Документ.ЗаказПокупателя КАК ЗаказПокупателя
	               |ГДЕ
	               |	ЗаказПокупателя.Ссылка = &Ссылка";
	
	Запрос.УстановитьПараметр("Ссылка", ДанныеЗаполнения);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Если Не Выборка.Следующий() Тогда
		Возврат;
	КонецЕсли;
	
	ЗаполнитьЗначенияСвойств(ЭтотОбъект, Выборка);
	
	ТоварыОснования = Выборка.Товары.Выбрать();
	Пока ТоварыОснования.Следующий() Цикл
		ЗаполнитьЗначенияСвойств(Товары.Добавить(), ТоварыОснования);
	КонецЦикла;
	
	УслугиОснования = Выборка.Услуги.Выбрать();
	Пока ТоварыОснования.Следующий() Цикл
		ЗаполнитьЗначенияСвойств(Услуги.Добавить(), УслугиОснования);
	КонецЦикла;
	
	Основание = ДанныеЗаполнения;
	
КонецПроцедуры

Процедура ВыполнитьАвтозаполнение(ДанныеФормы) Экспорт
	// {{ Алексеев М.Д.: Выполнение процедуры  "ВыполнитьАвтозаполнение()" 
	УслугаАбонентскаяПлата = Константы.ВКМ_НоменклатураАбонентскаяПлата.Получить();
	
	УслугаРаботыСпециалиста = Константы.ВКМ_НоменклатураРаботыСпециалиста.Получить();
	
	Если Не ЗначениеЗаполнено(УслугаАбонентскаяПлата) Или Не ЗначениеЗаполнено(УслугаРаботыСпециалиста) Тогда
		ВызватьИсключение ("Не заполнены константы НоменклатураАбонентскаяПлата или НоменклатураРаботыСпециалиста");
		Возврат;
	КонецЕсли;
	
	Товары.Очистить(); 
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	ДоговорыКонтрагентов.Ссылка КАК Договор,
	               |	МАКСИМУМ(ЕСТЬNULL(ДоговорыКонтрагентов.ВКМ_СуммаАбоненскойПлаты, 0)) КАК СуммаАбоненскойПлаты,
	               |	СУММА(ЕСТЬNULL(ВКМ_ВыполненныеКлиентуРаботыОбороты.СуммаКОплатеПриход, 0)) КАК СуммаРаботПоДоговору
	               |ИЗ
	               |	Справочник.ДоговорыКонтрагентов КАК ДоговорыКонтрагентов
	               |		ЛЕВОЕ СОЕДИНЕНИЕ РегистрНакопления.ВКМ_ВыполненныеКлиентуРаботы.Обороты(&НачалоПериода, &КонецПериода, Месяц, Договор = &СсылкаДоговор) КАК ВКМ_ВыполненныеКлиентуРаботыОбороты
	               |		ПО ДоговорыКонтрагентов.Ссылка = ВКМ_ВыполненныеКлиентуРаботыОбороты.Договор
	               |ГДЕ
	               |	ДоговорыКонтрагентов.Ссылка = &СсылкаДоговор
	               |
	               |СГРУППИРОВАТЬ ПО
	               |	ДоговорыКонтрагентов.Ссылка";
	
	Запрос.УстановитьПараметр("НачалоПериода",НачалоМесяца(ДанныеФормы.Дата));
	Запрос.УстановитьПараметр("КонецПериода",КонецМесяца(ДанныеФормы.Дата));
	Запрос.УстановитьПараметр("СсылкаДоговор", ДанныеФормы.Договор);
	
	Выборка = Запрос.Выполнить().Выбрать();

	Пока Выборка.Следующий() Цикл
		
		Если Выборка.СуммаАбоненскойПлаты > 0 Тогда
			НоваяСтрока = Товары.Добавить();
			НоваяСтрока.Номенклатура = УслугаАбонентскаяПлата;
			НоваяСтрока.Сумма = Выборка.СуммаАбоненскойПлаты;
		КонецЕсли;
		
		Если Выборка.СуммаРаботПоДоговору > 0 Тогда
			НоваяСтрока = Товары.Добавить();
			НоваяСтрока.Номенклатура = УслугаРаботыСпециалиста; 
			НоваяСтрока.Сумма = Выборка.СуммаРаботПоДоговору;
		КонецЕсли;
		
	КонецЦикла;
	//}}
КонецПроцедуры

#КонецОбласти

#КонецЕсли
