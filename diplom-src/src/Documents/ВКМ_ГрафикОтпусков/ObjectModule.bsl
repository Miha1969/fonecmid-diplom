#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий
Процедура ОбработкаПроведения(Отказ, Режим)
	
	Если ОтпускаСотрудников.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	ВКМ_ГрафикОтпусковОтпускаСотрудников.Сотрудник КАК Сотрудник,
	|	СУММА(РАЗНОСТЬДАТ(ВКМ_ГрафикОтпусковОтпускаСотрудников.ДатаНачала, ВКМ_ГрафикОтпусковОтпускаСотрудников.ДатаОкончания, ДЕНЬ)) КАК ДнейОтпуска
	|ИЗ
	|	Документ.ВКМ_ГрафикОтпусков.ОтпускаСотрудников КАК ВКМ_ГрафикОтпусковОтпускаСотрудников
	|ГДЕ
	|	ВКМ_ГрафикОтпусковОтпускаСотрудников.Ссылка = &Ссылка
	|
	|СГРУППИРОВАТЬ ПО
	|	ВКМ_ГрафикОтпусковОтпускаСотрудников.Сотрудник";
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка); 
	Движения.ВКМ_ГрафикОтпусков.Записывать = Истина;
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		Движение = Движения.ВКМ_ГрафикОтпусков.Добавить();
		Движение.Период = Дата;
		ЗаполнитьЗначенияСвойств(Движение,Выборка); 
	КонецЦикла;
	
КонецПроцедуры
#КонецОбласти

#КонецЕсли