#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий
Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	
	Если СписокСотрудников.Количество() = 0 Тогда
		ОбщегоНазначения.СообщитьПользователю("Не заполнена табличная часть документа",,"СписокСотрудников","Объект.СписокСотрудников");
		Отказ = Истина;
		Возврат;
	КонецЕсли;
	
	РазмерПремии = Константы.ВКМ_РазмерФиксированнойПермии.Получить();
	Если Не ЗначениеЗаполнено(РазмерПремии) Тогда
		ОбщегоНазначения.СообщитьПользователю("Не установлен размер фиксированой премии. Расчет  не будет выполнен");
		Отказ = Истина;
		Возврат;
	КонецЕсли;      
	
	СформироватьДвиженияИРасчет(РазмерПремии);
	
КонецПроцедуры
#КонецОбласти

#Область СлужебныеПроцедурыИФункции
Процедура СформироватьДвиженияИРасчет(РазмерПремии)
	
	Для Каждого Строка Из СписокСотрудников Цикл
		
		Движение = Движения.ВКМ_ДополнительныеНачисления.Добавить();
		Движение.ВидРасчета = ПланыВидовРасчета.ВКМ_ДополнительныеНачисления.Премия;
		Движение.ПериодРегистрации = Дата;
		Движение.БазовыйПериодНачало = НачалоМесяца(Дата);
		Движение.БазовыйПериодКонец = КонецМесяца(Дата)- 86399;
		Движение.Сотрудник = Строка.Сотрудник;
		Движение.Результат = РазмерПремии;

		Строка.СуммаПремии = РазмерПремии;
		
	КонецЦикла;
	
	Движения.ВКМ_ДополнительныеНачисления.Записать();
	
КонецПроцедуры

Процедура РасчитатьУдержаниеНДФЛ() 
	
	РазмерНДФЛ = 13;
		
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	ВКМ_ДополнительныеНачисления.НомерСтроки КАК НомерСтроки,
	               |	ВКМ_ДополнительныеНачисления.Сотрудник КАК Сотрудник,
	               |	ВКМ_ДополнительныеНачисления.Подразделение КАК Подразделение,
	               |	ВКМ_ДополнительныеНачисления.Результат КАК Результат
	               |ИЗ
	               |	РегистрРасчета.ВКМ_ДополнительныеНачисления КАК ВКМ_ДополнительныеНачисления
	               |ГДЕ
	               |	ВКМ_ДополнительныеНачисления.Регистратор = &Ссылка";
	
	Запрос.УстановитьПараметр("Ссылка",Ссылка);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		Движение = Движения.ВКМ_ДополнительныеНачисления[Выборка.НомерСтроки - 1];
				
		ДвижениеНДФЛ = Движения.ВКМ_Удержание.Добавить();
		ДвижениеНДФЛ.ВидРасчета = ПланыВидовРасчета.ВКМ_Удержание.НДФЛ;
		ДвижениеНДФЛ.Основание = Движение.ВидРасчета;
		ЗаполнитьЗначенияСвойств(ДвижениеНДФЛ,Движение,,"ВидРасчета");
		
		ДвижениеНДФЛ.Результат = Движение.Результат * РазмерНДФЛ / 100;
		ДвижениеНДФЛ.СуммаОснования = Движение.Результат; 
		
	КонецЦикла;
	
	Движения.ВКМ_Удержание.Записать(); 

КонецПроцедуры
#КонецОбласти

#КонецЕсли