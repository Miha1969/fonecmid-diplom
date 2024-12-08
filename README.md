# Инструкция по работе с новым функциональным блоком в конфигурации «Управление IT-фирмой»

## Кастомизация конфигурации «Управление IT-фирмой для компании «Ваш компьютерный мастер»


В состав нового функционального блока в конфигурации «Управление IT-фирмой»

Вошли следующие подсистемы и функциональности:

- подсистема «Обслуживание клиентов» работа с заявками клиентов,
- подсистемы «Кадровый учет» расчёт управленческой зарплаты,
- отчёты по новой функциональности,
- автотест для проверки корректности работы подсистемы «Работа с заявками клиентов»,
- В блок Releases репозитория добавлен dt-файл демонстрационной базы с введёнными тестовыми данными, которые показывают работу механизмов системы.

------

### Подсистема «Обслуживание клиентов» работа с заявками клиентов

Добавлен документ «Облуживание клиентов» в нем ведется запись заявок от клиентов и описание выполненных работ.
Добавлен новый вид договоров - абонентское обслуживание. В договорах такого вида пользователь может внести дату начала действия договора, дату окончания действия договора, сумму ежемесячной абонентской платы и стоимость часа работы специалиста.
Добавлена функциональность для оповещения через Телеграм.

Процесс работы с заявками построен следующим образом:

1. Клиент звонит менеджеру и оставляет заявку на работу специалиста с указанием проблемы, для решения которой нужен специалист.
2. Менеджер ищет свободное время и планирует заявку на это время.
3. При планировании телеграмм-бот оповещает специалистов о появлении новой заявки.
4. Специалист в назначенное время в офисе клиента или удалённо проводит необходимые работы.
5. Специалист получает подписанный лист учёта рабочего времени или скан/фото листа учёта от клиента. В листе учёта перечисляются виды   работ, выполненные специалистом, и фиксируется количество часов к оплате. В дальнейшем документ будет являться подтверждением проведения работ.
6. Специалист вносит в информационную систему информацию о выполненных работах, количество фактически потраченных часов на каждый вид работы, количество часов к оплате клиенту за каждый вид работы и прикрепляет к документу скан/фото листа учёта рабочего времени.
   
Для корректной работы подсистемы требуется выполнить следующие действия:

Для первичной настройки программы требуется зайти под пользователем «Администратор», в дальнейшем для работы в документе при первичном создании заявки  используем пользователя «Менеджер».
Открываем  подсистему «Обслуживание клиентов», в ней открыть документ «Облуживание клиентов», в котором заполнить реквизит «Клиент» нажав справа в окошке реквизита «Открыть»,
и выбрать из списка созданных контрагентов, либо нажав кнопку создать , создать нового.
Далее заполняем реквизит «Договор», выполняя те же действия что и на предыдущем шаге, при создании нового договора, на форме  обязательно выбираем  в реквизите «Вид договора» из выпадающего списка, строку «Абонентское обслуживание». Заполняем дату начало и окончания, стоимость часа работы и сумму абонентской платы.
Далее заполняем следующие реквизиты:
«Специалист» в нем  из выпадающего списка выбираем  пользователя с правами специалиста по обслуживанию клиентов, в данном случае выбираем «Специалист».
Реквизит «Дата проведения работ»  заполняем предполагаемой датой выезда специалиста по заявке.
Реквизиты «Время начало работ»  и «Время окончания работ»  заполняем предполагаемым периодом, часы и минуты, требуемым  для выполнения работ. 
В реквизите «Описание проблемы» заполняем сформулированную задачу. Документ записываем или проводим, нажав соответствующие кнопки на форме.
Часть работы по заполнению документа выполнена, создана заявка на выполнения работ у клиента.

Для оповещения выбранного специалиста по средствам телеграмм бота, требуется заполнить в подсистеме «Обслуживание клиентов»,
под заголовком «Сервис», следующие константы:
- «Идентификатор группы для оповещения» в ней сохраняем значение следующего вида «-4588070694» полученного от Телеграмм.
- «Токен управления телеграмм ботом» в ней сохраняем значение следующего вида «***************28x42nP9JbxUEHqiYuD2yipIN7aoAXw» полученного от Телеграмм. 
Если константы будут не заполнены, система об этом сообщит.

Далее с документом работает пользователь  «Специалист», он заполняет табличную часть документа. 
В «Описание работ» заполняет  выполненные им работы  и  реквизиты «Фактически потрачено часов» и «Часы к оплате клиенту».
Если требуется оставляет комментарий в реквизите «Комментарий» и проводит документ.

Также для работы с другой функциональностью требуется  в подсистеме «Обслуживание клиентов», под заголовком «Сервис», следующие константы:
- «Номенклатура абонентская плата» в ней сохраняем номенклатуру «Абонентская плата» , созданную в Справочнике «Номенклатура» где «Вид номенклатуры» установлен «Услуга».
- «Номенклатура работы специалиста» в ней сохраняем номенклатуру «Работы специалиста» , созданную в Справочнике «Номенклатура» где «Вид номенклатуры» установлен «Услуга».
          
Для удобства создания актов по реализации оказанных услуг, организован сервис «Массовое создание актов».
Данная обработка доступна для пользователя «Бухгалтер».
Расположена обработка в подсистеме «Покупки и продажи», под заголовком «Сервис».
Данна обработка автоматически создает акты «Реализации товаров и услуг» в заданный период, заполняя эти документы оказанными услугами и текущей «Абонентской платой», для каждого контрагента.
При открытии обработки требуется указать период. Обработка отобразит существующие договора обслуживания и если акты созданы, отобразит их. Иначе при нажатии кнопки создать, обработка создаст и проведет документы на основе отображенных договоров.
Если все пройдет успешно, система сообщит об этом пользователю. Для отображения созданых актов на форме, нажмите кнопку «Обновить».

------

### Подсистемы «Кадровый учет» расчёт управленческой зарплаты,

Данная подсистема доступна для пользователя «Кадровик». В ней реализован учет начисленной зарплаты и фикстрованных премий, а также график отпусков. В начале работы с подсистемой требуется заполнить константу «РазмерФиксированойПремии» под заголовком «Сервис», в ней сохранить размер премии, также нужно заполнить график через обработку «Заполнение графика», в ней указать выбранный период в рамках года, выбрав все месяцы года, в реквизите «Выходные дни» указать числа порядковых номеров выходных дней в рамках недели. Пример пятидневки «6,7».
Также необходимо заполнить в подсистеме  регистр сведений «Условия оплаты сотрудников» для каждого сотрудника, заполнив реквизиты «Сотрудник», «Оклад», «Процент от работ».
Подсистема в себе содержит следующие документы:
- «Начисление зарплат» документ для организации учета начисленной зарплаты, при открытии «Дата» должна отображать дату в текущем периоде начисления, в документе заполняется табличная часть, столбцы «Сотрудник», «Подразделение», «Вид расчета» оклад или отпуск, «Дата начала» дата начала начисления и «Дата окончания» дата окончания начисления.
- «Начисление фиксированной премии» документ для организации учета начисленной премии, при открытии «Дата» должна отображать дату в текущем периоде начисления, в документе заполняется табличная часть, столбцы «Сотрудник», «Сумма премии» заполняется автоматически при проводке документа.
- «Выплата зарплаты» документ для формирования зарплат в текущем периоде на основе начислений. Документ при открытии формирует, заполняя табличную часть, суммы выплаты зарплат по сотрудникам автоматически.
- «График отпусков» документ для организации учета запланированных отпусков. В документе заполняется реквизит «Год» числом текущего года. В табличной части заполняются столбцы «Сотрудник» и «Дата начала» дата начала периода отпуска, «Дата окончания» дата окончания периода отпуска. В случае если общая длительность отпуска  сотрудника  более 28 календарных дней, осуществляется подсветка строк серым цветом. Так же в документе имеется возможность  просмотра анализа графика с запланированными отпусками сотрудников  в выбранном году, отображенным в виде диаграммы Ганта. Для просмотра диаграммы нужно нажать на кнопку «Открыть анализ графика».

------

### Отчёты по новой функциональности

- «Выработка специалистов» отчет находится в подсистеме «Обслуживание клиентов».
Отчёт  показывает сколько часов за выбранный период отработал выбранный специалист и какая сумма ему за этот период начислена в виде процента от выплат клиента. Отчет доступен пользователям «Специалист» и «Кадровик»
- «Анализ выставленных актов» отчет находится в подсистеме «Покупки и продажи».
Отчёт показывает информацию о клиентах, договорах и суммах, которые  выставлены клиентам на основе данных из документов Обслуживание. Также показывает фактическую сумму по номенклатуре из константы НоменклатураРаботыСпециалиста, которая была выставлена в текущем месяце. Отчет доступен пользователю «Бухгалтер».
- «Расчёты с сотрудниками» отчет находится в подсистеме «Кадровый учет».
В отчёте  представлена информация о том, какие суммы начислены и выплачены каждому сотруднику за указанный период. Также в отчете указана задолженность на начало и на конец этого периода. Отчет доступен пользователю «Кадровик».
- Расход запланированных отпусков отчет находится в подсистеме «Кадровый учет».
Отчёт показывает сколько дней отпуска у сотрудника в выбранный период по плану и сколько дней он фактически был в отпуске. Отчет доступен пользователю «Кадровик».

------

### Автотесты для проверки работоспособности нового функциональный блока

- [Тестирование](tasks/testing.md).

------

