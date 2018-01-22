# Домашнее задание

## Список объектов

* `ow_accounts.sql` - скрипт создания таблицы, описывающая счета
* `ow_turnovers.sql` - скрипт создания таблицы, описывающей обороты по счетам
* `test_fill.sql` - скрипт заполнения таблиц тестовыми данными
* `install.sql` - скрипт запуска установки объектов
* `tasks.sql` - файл с запросами по заданию
* `get_prc_summ.sql` - скрипт создания функции из задания

## Установка

Установка выполняется командой:
`sqlplus < схема >/< пароль >@< SID > @install.sql`, где:
* **< схема >** - название схемы, в которую происходит установка
* **< пароль >** - пароль схемы
* **< SID >** - SID БД

Пример: `sqlplus apps/apps@DVLP_R12 @install.sql`

После установки будет создан файл `OW_INSTALL.log` с информацией об установке

## Текст задания

Спроектируйте структуру таблиц для ведения информации о счетах, движениях по счетам и остатках.
По сформированной структуре напишите запросы чтобы получить:
* текущий остаток по счету
* остаток по счету на произвольную дату
* дебетовый (расходный) и кредитовый (приходный) оборот по счету за произвольный период, то есть сумму списаний и поступлений на счет

Напишите функцию для расчета процентов по остаткам на счете.
* Параметры функции: `Счет`, `Дата начала периода`, `Дата окончания периода`, `Процентная ставка`.
* Результат функции: `сумма процентов`
* Базовая формула для расчета процентов за период: `СуммаПроцентов` =  `ОстатокНаСчете` * `ПроцентнаяСтавка` * `ДнейВПериоде` / `КоличествоДнейВГоду`

Формула используется для периодов, в которых остаток на счете не менялся. Если в расчетном периоде остаток менялся, то период делится на части и проценты по ним складываются.

В качестве остатка для расчета процентов используется входящий остаток по счету на начало дня. То есть если в течение дня остаток по счету менялся, то для расчета процентов за этот день используется остаток, который был на счете до сегодняшних движений.

## Тест функции для расчета процентов

Пусть функция называется get_prc_summ и принимает параметры:
* p_account_code = '95'
* p_start_date = date '2017-10-17'
* p_end_date = date '2018-01-14'
* p_prc_rate = 10

Т.е. запрашиваем сумму процентов по счету с кодом 95 за период (17.10.2017 - 14.01.2018 включая границы) с учетом процентной ставки, равной 10%.

Поскольку на стыке годов может произойти изменение числа дней в году, а также остаток на счете за расчетный период может изменяться, то весь период разобьется на следующие более мелкие периоды:

Дата начала периода|Дата окончания периода|Остаток на период
-------------------|----------------------|-------------------
17.10.2017|25.11.2017|273,25
26.11.2017|31.12.2017|1136,51
01.01.2018|13.01.2018|1136,51
14.01.2018|14.01.2018|579,32

Т.к. изменения на счете проводились уже в течение дня, то на сами даты (25.11.2017 и 13.01.2018) считаем остаток еще без изменений, а уже на следующий день - обновленный.
Поэтому для текущих входных параметров функция должна возвращать значение: 18.41 (используется математическое округление до двух знаков при расчете процентов за каждый период сохранения остатка).
