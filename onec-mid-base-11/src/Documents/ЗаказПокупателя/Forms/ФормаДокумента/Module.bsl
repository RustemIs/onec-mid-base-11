
#Область ОбработчикиСобытийФормы
Процедура ДЗ_ДобавитьКонтактноеЛицоВГруппеШапкаПраво(Форма)
	// ++ДЗ 11.2
	ПолеВвода = Форма.Элементы.Добавить("КонтактноеЛицо",Тип("ПолеФормы"),Форма.Элементы.ГруппаШапкаПраво);
	ПолеВВода.Вид = ВидПоляФормы.ПолеВвода;
	ПолеВвода.ПутьКданным = "Объект.ДЗ_КонтаткноеЛицо"; 
	//-- ДЗ 11.2
	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	// ++ДЗ 11.2
	Команда = Команды.Добавить("ДЗ_ПересчитатьТаблицу");
	Команда.Заголовок = "Пересчитать таблицу";
	Команда.Действие = "ДЗ_ПересчитатьТаблицу";
	
	ДЗ_ДобавитьКонтактноеЛицоВГруппеШапкаПраво(ЭтотОбъект);
	
	//-- ДЗ 11.2 
	
	
КонецПроцедуры

&НаКлиенте
Процедура ДЗ_ПересчитатьТаблицу (Команда);
	
	ДЗ_ОбщМетодПересчТабИИзмСкидки();
	
КонецПроцедуры 
&НаКлиенте
Асинх Процедура ДЗ_СогласованнаяСкидкаПриИзменении(Элемент)
	// ++ДЗ 11.2
	
	Если  Элементы.Товары.ТекущиеДанные <> Неопределено Или Элементы.Услуги.ТекущиеДанные <> Неопределено Тогда 
		
		
		
		Ответы = Новый СписокЗначений;
		Ответы.Добавить("Да");
		Ответы.Добавить("Нет");
		ОтветыАсинх = ВопросАсинх("Изменена скидка.Пересчитать с учетом скидки?",Ответы);
		Ответ = Ждать ОтветыАсинх; 
		
		Если Ответ = "Да" Тогда
			ДЗ_ОбщМетодПересчТабИИзмСкидки();
		КонецЕсли; 
	КонецЕсли;
	//-- ДЗ 11.2 
	
КонецПроцедуры 

&НаКлиенте
Процедура ДЗ_ОбщМетодПересчТабИИзмСкидки()
	
	Перем ТоварыИлиУслуги;
	
	ТоварыИлиУслуги = Объект.Товары;
	ДЗ_ПересчитатьТаблицуФрагмент(ТоварыИлиУслуги);
	
	ТоварыИлиУслуги = Объект.Услуги;
	ДЗ_ПересчитатьТаблицуФрагмент(ТоварыИлиУслуги);
	
КонецПроцедуры

&НаКлиенте
Процедура ДЗ_ПересчитатьТаблицуФрагмент(Знач ТоварыИлиУслуги)//Перебор строк ТЗ в документе
	
	
	Для Каждого Строка Из ТоварыИлиУслуги Цикл 
		
		РассчитатьСуммуСтроки(Строка);// Расчет суммы по каждой строке Документа
		
	КонецЦикла;
	
КонецПроцедуры
Процедура ДЗ_ДобавитьКонтактноеЛицоВГруппеШапкаПраво(Форма)
	// ++ДЗ 11.2
	ПолеВвода = Форма.Элементы.Добавить("КонтактноеЛицо",Тип("ПолеФормы"),Форма.Элементы.ГруппаШапкаПраво);
	ПолеВВода.Вид = ВидПоляФормы.ПолеВвода;
	ПолеВвода.ПутьКданным = "Объект.ДЗ_КонтаткноеЛицо"; 
	
	
	
	ГруппаСкидкаИПересчет = Форма.Элементы.Добавить("СкидкаИПересчет",Тип("ГруппаФормы"),Форма.Элементы.ГруппаШапкаЛево);
	ГруппаСкидкаИПересчет.Вид = ВидГруппыФормы.ОбычнаяГруппа;
	ПолеВвода1 = Форма.Элементы.Добавить("ДЗ_СогласованнаяСкидка",Тип("ПолеФормы"),ГруппаСкидкаИПересчет);
	ПолеВВода1.Вид = ВидПоляФормы.ПолеВвода;
	ПолеВвода1.ПутьКданным = "Объект.ДЗ_СогласованнаяСкидка";
	ПолеВвода1.УстановитьДействие("ПриИзменении", "ДЗ_СогласованнаяСкидкаПриИзменении");
	
	КнопкаПересчитатьТаблицу = Элементы.Добавить("КнопкаПересчитатьТаблицу",Тип("КнопкаФормы"),ГруппаСкидкаИПересчет);
	КнопкаПересчитатьТаблицу.ИмяКоманды = "ДЗ_ПересчитатьТаблицу";
	КнопкаПересчитатьТаблицу.Вид = ВидКнопкиФормы.ОбычнаяКнопка;
	
	//-- ДЗ 11.2
КонецПроцедуры  





&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
    ПодключаемыеКомандыКлиент.ПослеЗаписи(ЭтотОбъект, Объект, ПараметрыЗаписи);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыТовары

&НаКлиенте
Процедура ТоварыКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыПриИзменении(Элемент)
	РассчитатьСуммуДокумента();
КонецПроцедуры

&НаКлиенте
Процедура ТоварыСкидкаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыУслуги

&НаКлиенте
Процедура УслугиКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиСкидкаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиПриИзменении(Элемент)
	РассчитатьСуммуДокумента();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура РассчитатьСуммуСтроки(ТекущиеДанные)
	
	КоэффициентСкидки = 1 - ТекущиеДанные.Скидка / 100;
	ТекущиеДанные.Сумма = ТекущиеДанные.Цена * ТекущиеДанные.Количество * КоэффициентСкидки;
	
КонецПроцедуры

&НаКлиенте
Процедура РассчитатьСуммуДокумента()
	
	Объект.СуммаДокумента = Объект.Товары.Итог("Сумма") + Объект.Услуги.Итог("Сумма");
	
КонецПроцедуры

#Область ПодключаемыеКоманды

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
    ПодключаемыеКомандыКлиент.НачатьВыполнениеКоманды(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПродолжитьВыполнениеКомандыНаСервере(ПараметрыВыполнения, ДополнительныеПараметры) Экспорт
    ВыполнитьКомандуНаСервере(ПараметрыВыполнения);
КонецПроцедуры

&НаСервере
Процедура ВыполнитьКомандуНаСервере(ПараметрыВыполнения)
    ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, ПараметрыВыполнения, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти

#КонецОбласти
