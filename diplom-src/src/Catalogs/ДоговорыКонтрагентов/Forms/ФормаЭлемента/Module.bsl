#Область ОбработчикиСобытийФормы
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка) 
	//{{Алексеев.М.Д.: Добавление реквизитов на формы "ПериооДейстыия","СуммаАбаненскойПлаты", "СтоимостьЧасаРаботы" с условием 
	Группа = Элементы.Добавить("ГруппаШапка", Тип("ГруппаФормы"), ЭтотОбъект);
	Группа.Вид = ВидГруппыФормы.ОбычнаяГруппа;
	Группа.Заголовок = "Заполните рекквизиты договора Абаненского Облуживания:";
	Группа.Группировка = ГруппировкаПодчиненныхЭлементовФормы.Вертикальная;
	Если Объект.ВидДоговора <> Перечисления.ВидыДоговоровКонтрагентов.ВКМ_АбаненскоеОбслуживание Тогда
		Группа.Видимость = Ложь;
	КонецЕсли;
	
	ДобовляемыеРеквизиты = Новый Массив;
	ДобовляемыеРеквизиты.Добавить("ВКМ_ДатаНачала");
	ДобовляемыеРеквизиты.Добавить("ВКМ_ДатаОкончания");
	ДобовляемыеРеквизиты.Добавить("ВКМ_СтоимостьЧасаРаботы");
	ДобовляемыеРеквизиты.Добавить("ВКМ_СуммаАбоненскойПлаты");
	
	Для Каждого Реквизит Из ДобовляемыеРеквизиты Цикл
		ПолеПериодДействия = Элементы.Добавить(Реквизит, Тип("ПолеФормы"), Группа);
		ПолеПериодДействия.Вид = ВидПоляФормы.ПолеВвода;
		ПолеПериодДействия.ПутьКДанным = "Объект." + Реквизит;
	КонецЦикла;
	//}}
КонецПроцедуры
#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы
&НаКлиенте
Процедура ВидДоговораПриИзменении(Элемент)
	//{{Алексеев.М.Д.:
	ТекущиеДанные = Элементы.ГруппаШапка;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	Если Объект.ВидДоговора = ПредопределенноеЗначение("Перечисление.ВидыДоговоровКонтрагентов.ВКМ_АбаненскоеОбслуживание") Тогда
		ТекущиеДанные.Видимость = Истина;
	Иначе
		ТекущиеДанные.Видимость = Ложь;
	КонецЕсли;
	//}}
КонецПроцедуры
#КонецОбласти
