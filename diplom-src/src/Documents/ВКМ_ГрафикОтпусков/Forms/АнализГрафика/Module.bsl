#Область ОбработчикиСобытийФормы
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	    ДанныеДокумента = ПолучитьИзВременногоХранилища(Параметры.АдресХранилища);
		Серия = Диаграмма.УстановитьСерию("Отпуска");
	
	Для Каждого Строка Из ДанныеДокумента Цикл
		
		Точка = Диаграмма.УстановитьТочку(Строка.Сотрудник);
		Значение = Диаграмма.ПолучитьЗначение(Точка,Серия);
		
		Интервал = Значение.Добавить();
		Интервал.Начало = Строка.ДатаНачала;
		Интервал.Конец = Строка.ДатаОкончания;
		
	КонецЦикла;	
	
КонецПроцедуры
#КонецОбласти