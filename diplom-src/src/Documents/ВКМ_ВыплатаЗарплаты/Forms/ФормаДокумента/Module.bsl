
#Область ОбработчикиСобытийФормы
&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ПриОткрытииНаСервере();
КонецПроцедуры
#КонецОбласти

#Область СлужебныеПроцедурыИФункции
&НаСервере
Процедура ПриОткрытииНаСервере()
	
	РеквизитОбъект = РеквизитФормыВЗначение("Объект");
	РеквизитОбъект.ВыполнитьАвтозаполнение();
	ЗначениеВРеквизитФормы(РеквизитОбъект, "Объект");
	
КонецПроцедуры
#КонецОбласти
