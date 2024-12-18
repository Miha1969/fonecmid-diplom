#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныеПроцедурыИФункции
Функция СозданиеДокумента(ДоговорСсылка, ВыбранныйПериод)Экспорт 
	    
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	ДоговорыКонтрагентов.Организация КАК Организация,
	               |	ДоговорыКонтрагентов.Владелец КАК Контрагент,
	               |	ДоговорыКонтрагентов.Ссылка КАК Договор
	               |ИЗ
	               |	Справочник.ДоговорыКонтрагентов КАК ДоговорыКонтрагентов
	               |ГДЕ
	               |	ДоговорыКонтрагентов.Ссылка В(&Ссылка)"; 
	
	Запрос.УстановитьПараметр("Ссылка", ДоговорСсылка);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		НовыйДокумент = Документы.РеализацияТоваровУслуг.СоздатьДокумент();
		
		ДатаПериода = ВыбранныйПериод.ДатаОкончания; 
		ТекДата = ТекущаяДатаСеанса();
		
		Если ТекДата > ДатаПериода Тогда	
			НовыйДокумент.Дата = ДатаПериода;
		Иначе 
			НовыйДокумент.Дата = ТекДата;
		КонецЕсли;
		
		НовыйДокумент.Организация = Выборка.Организация; 
		НовыйДокумент.Контрагент = Выборка.Контрагент;
		НовыйДокумент.Договор = Выборка.Договор;
        НовыйДокумент.Комментарий = "Документ создан автоматически через ''Массовое создание актов''";
		НовыйДокумент.Ответственный = Пользователи.ТекущийПользователь();
		
		ДанныеДокумента = Новый Структура("Договор,Дата");
		ЗаполнитьЗначенияСвойств(ДанныеДокумента,НовыйДокумент); 
		
		НовыйДокумент.ВыполнитьАвтозаполнение(ДанныеДокумента);
		
		НовыйДокумент.Записать(РежимЗаписиДокумента.Проведение, РежимПроведенияДокумента.Неоперативный);
	КонецЦикла;
	
	
	Возврат "Документы реаилизации созданы"; 
	
КонецФункции
#КонецОбласти

#КонецЕсли